//
//  Utils.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import Foundation
func htmlString(_ string:String) -> NSAttributedString {
    var attrStr = NSAttributedString()
    let htmlDesc = "<style>body{font-family:open-sans,sans-serif;font-size:16px;line-height:24px;color:#8A8A8F;text-align: justify;}</style>\(string)"
    do {
        attrStr = try NSAttributedString(
            data: htmlDesc.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        
    } catch let error {
        print(error)
    }
    return attrStr
}

func setupDateFormater(format:String)-> DateFormatter{
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = format
    dateFormater.locale = Locale(identifier: SETTINGS.locale)
    dateFormater.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation()!)
    return dateFormater
}
