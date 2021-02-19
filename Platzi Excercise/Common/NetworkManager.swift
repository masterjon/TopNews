//
//  NetworkManager.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import Foundation
import SwiftyJSON

struct NetworkManager {
    func getNews(url:String, completion:@escaping([Article]?)->()){
        URLSession.shared.dataTask(with: URL(string: url)!){
            (data, urlResponse, error) in
            
            if let error = error{
                print(error.localizedDescription)
                completion(nil)
            }
            else if let data = data {
                let newsJSON = JSON(data)
                guard let adata = try? newsJSON["articles"].rawData(),
                      let articles : [Article] = try? JSONDecoder().decode([Article].self, from:adata )
                else {completion(nil); return}
                completion(articles)
                
                
            }
        }.resume()
    }
    func getImage(url:String,completion:@escaping(UIImage?)->()){
        
        URLSession.shared.dataTask(with: URL(string: url)!){
            (data, urlResponse, error) in
            if let error = error{
                print(error.localizedDescription)
                completion(nil)
            }
            else if let data = data {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
                
            }
        }.resume()
    }
}
