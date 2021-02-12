//
//  ArticleDetailViewController.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var moreAboutLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var relatedCollectionView: UICollectionView!
    var relatedArticles =  [Article]()
    
    let networkManager = NetworkManager()
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = article.title
        publishedAtLabel.text = article.getFriendlyDateString()
        contentTextView.attributedText = article.htmlDescription()
        article.getImage{ image in self.imageView.image = image}
        sourceLabel.text = "Source: \(article.source.name)"
        moreAboutLabel.text = "More news from \(article.source.name)"
        fetchRelatedArticles()
        
    }
    
    func fetchRelatedArticles(){
        guard let articleId = article.source.id else {return}
        networkManager.getNews(url: APPURL.newsBySourceURL(sourceId: articleId)) { articles in
            guard let articles = articles else{return}
            
            self.relatedArticles = articles.filter({ return $0.title != self.article.title})
            self.relatedCollectionView.reloadData()
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let indexPath = relatedCollectionView.indexPathsForSelectedItems?.first,
            let detailViewController = segue.destination as? ArticleDetailViewController
            else {return}
        detailViewController.article = relatedArticles[indexPath.item]
    }

}

extension ArticleDetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCollectionViewCell
        let article = relatedArticles[indexPath.row]
        cell.setupCell(article)
        return cell
    }
    


}
