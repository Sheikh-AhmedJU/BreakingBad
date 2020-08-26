//
//  CharacterViewModel.swift
//  BreakingBad
//
//  Created by Sheikh Ahmed on 25/08/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit



//MARK: View Model to handle each character
class CharacterViewModel{
    private let character: Character
    init(character: Character){
        self.character = character
    }
    
    // character image
    var image: String?{
        return character.img
    }
    // profile image
    var profileImage: UIImage? {
        let imageCache = AutoPurgingImageCache()
        guard let imageString = image, let imageURL = URL(string: imageString) else { return nil}
        
        let urlRequest = URLRequest(url: imageURL)
        var avatarImage = UIImage(named: "placeholder")
        if let image = imageCache.image(for: urlRequest, withIdentifier: imageString) {
            return image
        } else {
            AF.request(imageURL).responseImage { response in
                switch response.result {
                case .success(let image):
                    imageCache.add(image, withIdentifier: imageString)
                    avatarImage = image
                case .failure(_):
                    break
                }
            }
            return avatarImage
        }
    }
    
    // character name
    var name: String?{
        return character.name
    }
    
    // character ID
    var id: Int?{
        return character.charID
    }
    
    // character occupation
    var occupation: [String]?{
        return character.occupation
    }
    
    // character status
    var status: String?{
        return character.status
    }
    
    // character nickname
    var nickName: String?{
        return character.nickname
    }
    
    // season appearance
    var seasons: [Int]?{
        return character.appearance
    }
    
    // table header
    func getHeader(screen: Screens, section: Int)->String? {
        switch screen {
        case .ListScreen:
            return ""
        case .DetailScreen:
            return getDetailScreenHeader(section: section)
        }
    }
    // table cell data
    func getCellData(screen: Screens, section: Int)->String? {
        switch screen {
        case .ListScreen:
            return ""
        case .DetailScreen:
            return getDetailScreenData(section: section)
        }
    }
    
    private func getDetailScreenHeader(section: Int)->String?{
        switch section {
        case 0:
            return "Name"
        case 1:
            return "Occupation"
        case 2:
            return "Status"
        case 3:
            return "Nickname"
        case 4:
            return "Season appearance"
        default:
            return nil
        }
    }
    
    private func getDetailScreenData(section: Int)->String?{
        switch section {
        case 0:
            return name
        case 1:
            return occupation?.compactMap({ $0}).joined(separator: "\n")
        case 2:
            return status
        case 3:
            return nickName
        case 4:
            return seasons?.compactMap({ String($0)}).joined(separator: ", ")
        default:
            return nil
        }
    }
}
