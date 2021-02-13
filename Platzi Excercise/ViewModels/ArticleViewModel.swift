//
//  ArticleViewModel.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import Foundation
import UIKit

struct ArticleListViewModel {
    let articles : [Article]
    
    func numberOfItemsInSection() -> Int {
        return self.articles.count
    }
    func itemAtIndex(_ index:Int) -> ArticleViewModel{
        let article = articles[index]
        return ArticleViewModel(article)
    }
}
struct ArticleViewModel {
    private let article: Article
    init(_ article:Article){
        self.article = article
    }
    var title: String {
        return self.article.title
    }
    var description : String {
        return self.article.description ?? ""
    }
    var content : NSAttributedString{
        return self.article.htmlContent()
    }
    var published: String{
        return self.article.getFriendlyDateString()
    }
    var sourceId : String?{
        return self.article.source.id
    }
    var sourceName : String{
        return self.article.source.name 
    }
    
    
    func getImage(completion:@escaping(UIImage?)->()){
        self.article.getImage{ image in
            completion(image)
        }
    }
}

