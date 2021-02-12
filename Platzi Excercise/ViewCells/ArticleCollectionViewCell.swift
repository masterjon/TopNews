//
//  ArticleCollectionViewCell.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        
        let radius = CGFloat(8)
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func setupCell(_ articleVM:ArticleViewModel){
        self.titleLabel.text = articleVM.title
        self.titleLabel.textColor = .brown
        self.descriptionLabel.text = articleVM.description
        self.imgView.image = UIImage(named: "placeholder")
        articleVM.getImage{ image in
            self.imgView.image = image
        }
    }
}
