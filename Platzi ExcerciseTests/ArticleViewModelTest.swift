//
//  ArticleViewModelTest.swift
//  Platzi ExcerciseTests
//
//  Created by Jonathan Horta on 13/02/21.
//

import XCTest
@testable import Platzi_Excercise
class ArticleViewModelTest: XCTestCase {

    private var articleVM : ArticleViewModel!
    override func setUp() {
        super.setUp()
        articleVM = ArticleViewModel(
            Article(
                    title: "New",
                    description: "Desc",
                    content: "<ul><li>List Item</li></ul>",
                    urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/200213175739-03-coronavirus-0213-super-tease.jpg",
                    publishedAt: "2021-02-13T05:06:00Z",
                    author: "",
                    url: "https://www.cbssports.com/nfl/news/chris-doyle-resigns-from-jacksonville-jaguars-coaching-staff-after-backlash-per-report/",
                    source: Source(id: "cnn", name: "CNN")
            )
        )
    }
    
    func test_publishedAt_format(){
        XCTAssertEqual(articleVM.published, "Saturday, 13 Feb 2021 00:06")
    }
    
    func test_sourceName(){
        XCTAssertEqual(articleVM.sourceName, "CNN")
    }
    
    

}
