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
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var articleListViewModel : ArticleListViewModel!
    
    let networkManager = NetworkManager()
    var articleVM: ArticleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = articleVM.title
        publishedAtLabel.text =  articleVM.published
        contentTextView.attributedText =  articleVM.content
        
        articleVM.getImage{ image in self.imageView.image = image}
        sourceLabel.text = "Source: \(articleVM.source.name)"
        moreAboutLabel.text = "More news from \(articleVM.source.name)"
        fetchRelatedArticles()
        
    }
    
    func fetchRelatedArticles(){
        guard let articleId = articleVM.source.id else {return}
        networkManager.getNews(url: APPURL.newsBySourceURL(sourceId: articleId)) { articles in
            self.loadingIndicator.stopAnimating()
            guard let articles = articles else{return}
            
            let filteredArticles = articles.filter({ return $0.title != self.articleVM.title})
            
            self.articleListViewModel = ArticleListViewModel(articles:filteredArticles)
            
            DispatchQueue.main.async{
                self.relatedCollectionView.reloadData()
            }
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let indexPath = relatedCollectionView.indexPathsForSelectedItems?.first,
            let detailViewController = segue.destination as? ArticleDetailViewController
            else {return}
        detailViewController.articleVM = articleListViewModel.itemAtIndex(indexPath.item)
    }

}

extension ArticleDetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.articleListViewModel != nil{
            return articleListViewModel.numberOfItemsInSection()
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCollectionViewCell
        let articleViewModel = self.articleListViewModel.itemAtIndex(indexPath.row)
        cell.setupCell(articleViewModel)
        return cell
    }
    


}
