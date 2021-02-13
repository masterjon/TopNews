//
//  NetworkManager.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import Foundation
import Alamofire
import SwiftyJSON

struct NetworkManager {
    func getNews(url:String, completion:@escaping([Article]?)->()){
        print(url)
        AF.request(url).validate().responseJSON { response in
            switch response.result{
            case .success(let value):
                let newsJSON = JSON(value)
                guard let adata = try? newsJSON["articles"].rawData() else {return}
                let articles : [Article] = try! JSONDecoder().decode([Article].self, from:adata )
                completion(articles)
            case .failure(_):
                print("failure")
            }
            
        }
    }
    func getImage(url:String,completion:@escaping(UIImage?)->()){
        AF.request(url).responseData { response in
            guard let data = response.data else { completion(nil); return}
            completion(UIImage(data: data))
        }
    }
}
