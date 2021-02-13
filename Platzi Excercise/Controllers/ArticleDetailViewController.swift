//
//  ArticleDetailViewController.swift
//  Platzi Excercise
//
//  Created by Jonathan Horta on 11/02/21.
//

import UIKit
private let reuseIdentifier = "Cell"

class ArticleDetailViewController: UIViewController {

    // MARK: - Properties
    var articleListViewModel : ArticleListViewModel!
    var articleVM: ArticleViewModel!
    var collectionView:UICollectionView!

    let networkManager = NetworkManager()
    let loadingIndicator = LoadingIndicator(style: .large)
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    //TODO: - Some API images crash the app
    private lazy var  imageView: UIImageView = {
       let imageview = UIImageView(image: #imageLiteral(resourceName: "placeholder"))
        imageview.contentMode = .scaleAspectFill
        articleVM.getImage{ image in self.imageView.image = image}
        return imageview
    }()
    
    
    private let separatorView: UIView = {
       let view = UIView()
        view.setHeight(1)
        view.backgroundColor = ColorPalette.backgroundColor
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.6
        label.text = articleVM.title
        return label
    }()
    
    private lazy var  publishedAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = ColorPalette.secondaryColor
        label.numberOfLines = 1
        label.text = articleVM.published
        return label
    }()
    
    //TODO: Refactor labels
    private lazy var  contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        textView.textColor = ColorPalette.bodyColor
        textView.attributedText = articleVM.content
        textView.isScrollEnabled = false
        return textView
    }()
    
    private lazy var  sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = ColorPalette.secondaryColor
        label.numberOfLines = 1
        label.text = "Source: \(articleVM.sourceName)"
        return label
    }()
    
    private lazy var moreNewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.6
        label.text = "More news from \(articleVM.sourceName)"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRelatedArticles()
        navigationItem.largeTitleDisplayMode = .never
        setupUI()
    }

    // MARK: - UI
    
    func setupUI(){
        view.backgroundColor = .white
        setupScrollView()
        
        contentView.addSubview(imageView)
        imageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, height: 220)
        
        let stackView = setupStackView()
        contentView.addSubview(stackView)
        stackView.anchor(top: imageView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor,paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
        contentView.addSubview(moreNewsLabel)
        moreNewsLabel.anchor(top: stackView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 20 )
        
        setupCollectionView()
        contentView.addSubview(loadingIndicator)
        loadingIndicator.center(inView: collectionView)
        
    }
    
    func setupStackView() -> UIStackView{
        let subviews = [
            titleLabel,
            publishedAtLabel,
            contentTextView,
            sourceLabel,
            separatorView
        ]
        let stackView = UIStackView(arrangedSubviews:subviews )
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }
    
    func setupScrollView() {
            contentView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, width: view.bounds.width)
        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor,width: view.bounds.width)
    }
    
    
    func setupCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        collectionView =  UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.anchor(top: moreNewsLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        collectionView.backgroundColor = .white
        collectionView.setHeight(250)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    
    // MARK: - API
    
    func fetchRelatedArticles(){
        guard let articleId = articleVM.sourceId else {return}
        networkManager.getNews(url: APPURL.newsBySourceURL(sourceId: articleId)) { articles in
            self.loadingIndicator.stopAnimating()
            guard let articles = articles else{return}
            let filteredArticles = articles.filter({ return $0.title != self.articleVM.title})
            self.articleListViewModel = ArticleListViewModel(articles:filteredArticles)
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
    }
    

}

// MARK: - UICollectionViewDataSource

extension ArticleDetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.articleListViewModel != nil{
            return articleListViewModel.numberOfItemsInSection()
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArticleCollectionViewCell
        cell.articleVM = articleListViewModel.itemAtIndex(indexPath.row)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension ArticleDetailViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController =  ArticleDetailViewController()
        detailViewController.articleVM = articleListViewModel.itemAtIndex(indexPath.item)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ArticleDetailViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellWith = (self.view.frame.size.width - 15 * 2) / 1.5

        let width = cellWith //some width
        let height = cellWith  //ratio
        //let height = CGFloat(200)+60+30 //ratio
        return CGSize(width: width, height: height)
    }
}
