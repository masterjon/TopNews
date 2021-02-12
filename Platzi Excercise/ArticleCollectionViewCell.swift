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
    
    func setupCell(_ article:Article){
        self.titleLabel.text = article.title
        self.titleLabel.textColor = .brown
        self.descriptionLabel.text = article.description
        self.imgView.image = UIImage(named: "placeholder")
        article.getImage{ image in
            self.imgView.image = image
        }
        //self.titleLabel.textColor = UIColor.init(hexString: "#xxx")
        
//        Alamofire.request("https://images.mktw.net/im-298100/social").responseData { response in
//            self.logoImageView.image = UIImage(data: response.data!)
//        }
    }
}
