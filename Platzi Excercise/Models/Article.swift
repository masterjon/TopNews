//
//  Article.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import Foundation
import UIKit
let networkManager = NetworkManager()

struct Source: Decodable{
    let id:String?
    let name:String
}

struct Article: Decodable{
    let title:String
    let description:String?
    let content: String?
    let urlToImage:String?
    let publishedAt:String
    let author:String?
    let url : String
    let source:Source
    
    
    func getFriendlyDateString()->String{
        let dateFormatter = setupDateFormater(format: DateTimeFormats.apiDateTime)
        if let date = dateFormatter.date(from: self.publishedAt){
            let formater = setupDateFormater(format: DateTimeFormats.humanDate)
            return formater.string(from: date)
        }
        return ""
        
    }
    func getImage(completion: @escaping (UIImage?) -> ()){
        guard let url = self.urlToImage else { completion(nil); return}
            networkManager.getImage(url: url) { image in
                completion(image)
            }
    }
    func htmlContent()->NSAttributedString{
        return htmlString(self.content ?? "")
    }
}
