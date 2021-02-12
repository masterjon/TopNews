//
//  HomeViewController.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    let networkManager = NetworkManager()
    var articleListViewModel : ArticleListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    func setupVC(){
        networkManager.getNews(url: APPURL.topHeadlines) { articles in
            self.loadingIndicator.stopAnimating()
            guard let articles = articles else{return}
            self.articleListViewModel = ArticleListViewModel(articles:articles)
            print("article")
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
            
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let indexPath = collectionView.indexPathsForSelectedItems?.first,
            let detailViewController = segue.destination as? ArticleDetailViewController
            else {return}
        detailViewController.articleVM = articleListViewModel.itemAtIndex(indexPath.item)
    }
    
}


extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.articleListViewModel != nil{
            return self.articleListViewModel.numberOfItemsInSection()
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


//extension HomeViewController:UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        print("flow")
//        let cellWith = (self.view.frame.size.width - 15 * 2) / 2
//
//        let width = cellWith //some width
//        let height = cellWith * 0.7 //ratio
//        return CGSize(width: width, height: height)
//    }
//}
