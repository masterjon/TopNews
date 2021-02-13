//
//  LoadingIndicator.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 13/02/21.
//

import UIKit

class LoadingIndicator: UIActivityIndicatorView{
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        hidesWhenStopped = true
        startAnimating()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

