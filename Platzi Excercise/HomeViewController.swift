//
//  HomeViewController.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let networkManager = NetworkManager()
    var news =  [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getNews(url: APPURL.topHeadlines) { articles in
            guard let articles = articles else{return}
            self.news = articles
            self.collectionView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let indexPath = collectionView.indexPathsForSelectedItems?.first,
            let detailViewController = segue.destination as? ArticleDetailViewController
            else {return}
        detailViewController.article = news[indexPath.item]
    }
    
}


extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCollectionViewCell
        let article = news[indexPath.row]
        cell.setupCell(article)
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
