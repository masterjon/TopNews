//
//  ApiTest.swift
//  Platzi ExcerciseTests
//
//  Created by Jonathan Horta on 13/02/21.
//

import XCTest
@testable import Platzi_Excercise
class ApiTest: XCTestCase {
    let nm = NetworkManager()
    /// It should correctly fetch and parse the user.
    
    func test_headlines_fetching() {
        let e = expectation(description: "Alamofire")
        nm.getNews(url: APPURL.topHeadlines) { articles in
            XCTAssertNotNil(articles)
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_news_by_source_fetching_with_valid_source() {
        let e = expectation(description: "Alamofire")
        let sourceId = "cnn"
        print(APPURL.newsBySourceURL(sourceId: sourceId))
        nm.getNews(url: APPURL.newsBySourceURL(sourceId: sourceId)) { articles in
            XCTAssertNotNil(articles)
            let article = articles?.first
            XCTAssertEqual(article?.source.id, sourceId )
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_news_by_source_fetching_with_invalid_source() {
        let e = expectation(description: "Alamofire")
        let sourceId = "cnnn"
        nm.getNews(url: APPURL.newsBySourceURL(sourceId: sourceId)) { articles in
            XCTAssertNil(articles)
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_image_fetch_valid_url() {
        let e = expectation(description: "Alamofire")
        nm.getImage(url: "https://sportshub.cbsistatic.com/i/r/2020/06/06/0cc1de7f-e541-4d15-997b-3a07fd108595/thumbnail/1200x675/e06338e0fc01ba092ff7d2db49136c47/chris-doyle.jpg") { image in
            XCTAssertNotNil(image)
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_image_fetch_invalid_url() {
        let e = expectation(description: "Alamofire")
        nm.getImage(url: "https://sportshub.cbsistatic.com") { image in
            XCTAssertNil(image)
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
