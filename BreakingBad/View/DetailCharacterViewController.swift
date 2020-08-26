//
//  DetailCharacterViewController.swift
//  BreakingBad
//
//  Created by Sheikh Ahmed on 25/08/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

class DetailCharacterViewController: UIViewController {
    // IB outlet
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var chracterImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    // variables
    var viewModel: CharacterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupImageView()
        setupScreenTitle()
    }
    private func setupScreenTitle(){
        title = "Details"
    }
    private func setupImageView(){
        let image = UIImage(named: "placeholder")
        guard let imageString = viewModel?.image, let imageURL = URL(string: imageString) else {
            return }
        chracterImageView.af.setImage(withURL: imageURL, placeholderImage: image)
        
    }
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "detail")
    }
}
extension DetailCharacterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.getHeader(screen: .DetailScreen, section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = .byWordWrapping
        cell?.textLabel?.text = viewModel?.getCellData(screen: .DetailScreen, section: indexPath.section)
        return cell ?? UITableViewCell()
    }
    
    
}
