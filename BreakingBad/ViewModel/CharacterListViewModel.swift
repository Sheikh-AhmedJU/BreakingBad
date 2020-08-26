//
//  CharacterListViewModel.swift
//  BreakingBad
//
//  Created by Sheikh Ahmed on 25/08/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import Alamofire
import Foundation


protocol ViewModelDelegate: class {
    func willLoadData()
    func didLoadData()
}

protocol ViewModelType {
    func bootstrap()
    var delegate: ViewModelDelegate? { get set }
}


class CharacterListViewModel{
    var characters: Characters = []
    var isError: Bool = false
    var message: String?
    var isFinishedAPICall: Bool?
    var maxSeason: Int = 0
    internal weak var delegate: ViewModelDelegate?
    var selectedCharacters: Characters = []
    init(){
        
    }
    func filterSelectedCharacters(season: Int) -> Characters{
        characters.filter({ $0.appearance?.contains(season) ?? false })
    }
    func getAllCharacters()->Characters {
        self.characters
    }
    func filterSelectedCharacters(name: String?)->Characters{
        guard let searchText = name else {
            return getAllCharacters()
        }
        let names = getAllCharacters()
        let tempCharacters = names.filter { ($0.name?.contains(searchText) ?? false)
        }
        return tempCharacters
    }
}

extension CharacterListViewModel: ViewModelType {
    func bootstrap() {
        self.delegate?.willLoadData()
        let url = App.baseURL
        AF.request(url, method: .get)
        .validate()
            .responseDecodable(of: Array<Character>.self) {
                result  in
                switch result.result {
                case .failure(let error):
                    self.isError = true
                    self.message = error.localizedDescription
                case .success(let models):
                    self.characters = models
                    self.selectedCharacters = models
                    let maxSeason = models.compactMap { $0.appearance?.sorted(by: >).first}.sorted(by: >).first
                    self.maxSeason = maxSeason ?? 0
                    self.isError = false
                    self.message = nil
                }
                self.delegate?.didLoadData()
        }
    }
}
