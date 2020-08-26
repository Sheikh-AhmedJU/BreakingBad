//
//  BadCharacterListViewController.swift
//  BreakingBad
//
//  Created by Sheikh Ahmed on 25/08/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

class BadCharacterListViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    // local variables
    private var model: CharacterListViewModel?
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var tableData: Characters = []
    private var isSearchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
        setupTableView()
        setupViewModel()
        setupFilterButton()
        showFilterButton(shouldShow: false)
        setupSearchBar()
    }
    private func setupSearchBar(){
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
    private func setupFilterButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked) )
    }
    @objc private func filterButtonClicked(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "filterVC") as? FilterViewController else { return }
        vc.maxSeason = model?.maxSeason
        vc.delegate = self
        navigationController?.present(vc, animated: true)
    }
    private func setupScreenTitle(count: Int){
        title = "Characters(\(count))"
    }
    private func setupViewModel(){
        model = CharacterListViewModel()
        model?.delegate = self
        model?.bootstrap()
    }
    private func setupActivityIndicatorView(){
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
    }
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BadCharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "charactreCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    private func reloadTableData(){
        tableView.reloadData()
        setupScreenTitle(count: tableData.count )
        showFilterButton(shouldShow: tableData.count > 0)
    }
    private func showFilterButton(shouldShow: Bool){
        navigationItem.rightBarButtonItem?.isEnabled = shouldShow
    }
}
//MARK: Delegate with View Model
extension BadCharacterListViewController: ViewModelDelegate {
    func willLoadData() {
        activityIndicator.startAnimating()
        showFilterButton(shouldShow: false)
    }
    
    func didLoadData() {
        tableData = model?.selectedCharacters ?? []
        reloadTableData()
        activityIndicator.stopAnimating()
    }
}

extension BadCharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? tableData.count : model?.getAllCharacters().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        let characterCell = tableView.dequeueReusableCell(withIdentifier: "charactreCell") as! BadCharacterTableViewCell
        var character: Character?
        if isSearchActive {
            character = tableData[indexPath.row]
        } else {
            character = model?.getAllCharacters()[indexPath.row]
        }
        if let character = character {
            let viewModel = CharacterViewModel(character: character)
            characterCell.setupCell(characterViewModel: viewModel)
            cell = characterCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "detailVC") as? DetailCharacterViewController else { return }
        var character: Character?
        if isSearchActive {
            character = tableData[indexPath.row]
        } else {
            character = model?.getAllCharacters()[indexPath.row]
        }
        if let character = character {
            let viewModel = CharacterViewModel(character: character)
            vc.viewModel = viewModel
            navigationController?.pushViewController(vc, animated: true)
            searchBar.searchTextField.endEditing(true)
        }
    }
}

extension BadCharacterListViewController: SelectedSeasonDelegate {
    func seasonSelected(index: Int) {
        tableData = tableData.filter({ $0.appearance?.contains(index) ?? false})
        reloadTableData()
    }
}

extension BadCharacterListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableData = model?.filterSelectedCharacters(name: searchText) ?? []
        isSearchActive = true
        reloadTableData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        tableData = model?.getAllCharacters() ?? []
        searchBar.text = ""
        reloadTableData()
    }
}

