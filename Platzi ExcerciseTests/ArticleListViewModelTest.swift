//
//  ArticleListViewModelTest.swift
//  Platzi ExcerciseTests
//
//  Created by Jonathan Horta on 13/02/21.
//

import XCTest
@testable import Platzi_Excercise

class ArticleListViewModelTest: XCTestCase {

    private var articleListVM : ArticleListViewModel!
    
    override func setUp() {
        super.setUp()
        var articles = [Article]()
        for n in 0...10{
            articles.append(Article(title: "New\(n)", description: "Des", content: "", urlToImage: "", publishedAt: "", author: "", url: "", source: Source(id: "", name: "")))
        }
        
        self.articleListVM = ArticleListViewModel(articles:articles)
    }
    
    func test_number_of_items_is_correct(){
        XCTAssertEqual(self.articleListVM.numberOfItemsInSection(), 11)
        
    }
    
    func test_item_at_index_is_correct(){
        let index = 5
        let article = self.articleListVM.itemAtIndex(index)
        XCTAssertEqual(article.title, "New\(index)")
        
    }
    
    func test_filtered_articles_exluding_title(){
        let title = "New0"
        let articleListVM = self.articleListVM.filteredArticlesExluding(title: title)
        for article in articleListVM.articles{
            XCTAssertNotEqual(article.title, title)
        }
    }

}
