//
//  BadCharacterTableViewCell.swift
//  BreakingBad
//
//  Created by Sheikh Ahmed on 25/08/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class BadCharacterTableViewCell: UITableViewCell {

    // outlets
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    func setupCell(characterViewModel: CharacterViewModel?){
        guard let viewModel = characterViewModel else { return}
        characterName.text = viewModel.name
        let image = UIImage(named: "placeholder")
        guard let imageString = viewModel.image, let imageURL = URL(string: imageString) else {
            return }
        characterImage.af.setImage(withURL: imageURL, placeholderImage: image)
    }
    override func prepareForReuse() {
        characterImage.af.cancelImageRequest()
        characterImage.image = nil
        
    }
}
