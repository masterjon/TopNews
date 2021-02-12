//
//  Settings.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import Foundation


    
    
enum SETTINGS{
    static let locale = "en_US"
    static let apiKey = "ed3028f58e2e42c4a499759f9a368a39"
    static let sources = ["axios","bbc-news","bloomberg","google-news","techcrunch"]
}

enum DateTimeFormats{
    static let humanDate = "EEEE, d MMM yyyy HH:mm"
    static let apiDateTime = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    
}

enum APPURL {
    private enum Domains {
        static let dev = "https://newsapi.org"
        static let prod = "https://newsapi.org"
    }
    private  struct Routes {
        static let v2 = "/v2/"
    }
    
    #if DEBUG
    static let domain = Domains.dev
    #else
    static let domain = Domains.prod
    #endif
    
    static let baseURL = domain + Routes.v2
    static let topHeadlines = baseURL + "top-headlines?sources=\(SETTINGS.sources.joined(separator: ","))&pageSize=10&sortBy=publishedAt&apiKey=" + SETTINGS.apiKey
    static func newsBySourceURL(sourceId:String)->String{
        return baseURL + "everything?sources=\(sourceId)&sortBy=publishedAt&pageSize=5&apiKey=" +  SETTINGS.apiKey
    }
}
