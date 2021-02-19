//
//  HomeViewController.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {

    //MARK: - Properties
    var articleListViewModel : ArticleListViewModel!
    let networkManager = NetworkManager()
    let loadingIndicator = LoadingIndicator(style: .large)
    private lazy var refreshControl : UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Loading...")
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        
    }
    
    //MARK: - UI
    
    func setupUI(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Top News"
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = ColorPalette.backgroundColor
        view.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
        view.addSubview(loadingIndicator)
        loadingIndicator.center = self.view.center
        
        
    }
    
    @objc func refresh(){
        fetchData()
    }
    
    //MARK: - API
    
    func fetchData(){
        networkManager.getNews(url: APPURL.topHeadlines) { articles in
            guard let articles = articles else{return}
            self.articleListViewModel = ArticleListViewModel(articles:articles)
            DispatchQueue.main.async{
                self.loadingIndicator.stopAnimating()
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
            
        }
    }
    
    
}

// MARK: - UICollectionViewDataSource

extension HomeViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.articleListViewModel != nil{
            return self.articleListViewModel.numberOfItemsInSection()
        }
        return 0
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArticleCollectionViewCell
        cell.articleVM = self.articleListViewModel.itemAtIndex(indexPath.row)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension HomeViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController =  ArticleDetailViewController()
        detailViewController.articleVM = articleListViewModel.itemAtIndex(indexPath.item)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellWith = (self.view.frame.size.width - 15 * 2)

        let width = cellWith
        let height = cellWith * 0.8
        return CGSize(width: width, height: height)
    }
}
