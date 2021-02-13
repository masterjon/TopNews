//
//  ArticleCollectionViewCell.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    var articleVM :ArticleViewModel? {
        didSet {configure()}
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor =  ColorPalette.primaryColor
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = ColorPalette.bodyColor
        
        return label
    }()
    
    private let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        return stackView
    }()
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        layer.cornerRadius = CGFloat(8)
        clipsToBounds = true
        addSubview(imgView)
        imgView.anchor(top: topAnchor, left: leftAnchor,  right: rightAnchor)
        stackView.addArrangedSubview(titleLabel)
        titleLabel.setHeight(60)
        stackView.addArrangedSubview(descriptionLabel)
        addSubview(stackView)
        stackView.anchor(top: imgView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, height: 90)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(){
        guard let articleVM = articleVM else {return}
        self.titleLabel.text = articleVM.title
        self.descriptionLabel.text = articleVM.description
        self.imgView.image = UIImage(named: "placeholder")
        articleVM.getImage{ image in
            self.imgView.image = image
        }
    }
}
