//
//  ViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 4.10.2022.
//



import UIKit
import RxSwift
import RxCocoa
import SDWebImage

final class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var newsCollection: UICollectionView!
    @IBOutlet weak var metaCritic: UICollectionView!
    @IBOutlet weak var TopRated: UICollectionView!
    
   private var viewModel = HomeViewModel()
    
    var slug = String()
    private var bag = DisposeBag()
    
    private var  IsHidden = false
    
    let blurEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        bindingPopular()
        bindingMetaCritic()
        bindingNews()
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
  

    @objc func methodOfReceivedNotification(notification: NSNotification) {
        self.IsHidden = true
        showBlur(IsHidden: IsHidden)
    }
    
    private func bindingPopular() {
    
        self.viewModel.fetchPopularGames()
        TopRated.rx.setDelegate(self).disposed(by: bag)
        viewModel.popularsBehavior.bind(to: TopRated.rx.items(cellIdentifier: "TopRatedCollectionViewCell",cellType: TopRatedCollectionViewCell.self)) {
            section,item,cell in
           
            cell.gameName.text = item.name
            cell.gameImage.sd_setImage(with: URL(string: item.background_image))
        }.disposed(by: bag)
     
        TopRated.rx.modelSelected(Game.self)
            .subscribe { game in
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                
                detailVC.slug = game.slug
                self.navigationController?.pushViewController(detailVC, animated: true)
            }.disposed(by: bag)
        
    }
    private func bindingMetaCritic() {
        
        self.viewModel.fetchMetacriticGames()
        metaCritic.rx.setDelegate(self).disposed(by: bag)
        viewModel.metacriticBehavior.bind(to: metaCritic.rx.items(cellIdentifier: "MetaCriticCollectionViewCell",cellType: MetaCriticCollectionViewCell.self)) {
            section,item,cell in
            
            cell.gameName.text = item.name
            cell.gameImage.sd_setImage(with: URL(string: item.background_image))
        }.disposed(by: bag)
        
        metaCritic.rx.modelSelected(Game.self)
            .subscribe { game in
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                
                
                detailVC.slug = game.slug
                self.navigationController?.pushViewController(detailVC, animated: true)
            }.disposed(by: bag)
    
    }
    private func showBlur(IsHidden:Bool) {
      
        self.blurEffectView.frame = self.view.bounds
        self.view.addSubview(self.blurEffectView)
        self.blurEffectView.isHidden = IsHidden
        
    }
    
    private func bindingNews() {
        self.viewModel.fetchNews()
        newsCollection.rx.setDelegate(self).disposed(by: bag)
        viewModel.gameNewsBehavior.bind(to: newsCollection.rx.items(cellIdentifier: "NewsCollectionViewCell",cellType: NewsCollectionViewCell.self)) {
            section,item,cell in
            cell.newsImage.sd_setImage(with: URL(string: item.image))
      
        }.disposed(by: bag)
        
        newsCollection.rx.modelSelected(GameNews.self)
            .subscribe { news in
            let storyboard = UIStoryboard(name: "Sheet", bundle: nil)
                let sheetNewsVC =
                storyboard.instantiateViewController(withIdentifier: "SheetViewController") as! SheetViewController
                self.present(sheetNewsVC, animated: true)
               _ = news.map { element in
                    sheetNewsVC.titleLbl.text = element.title
                    sheetNewsVC.descriptionLbl.text = element.welcomeDescription
                    sheetNewsVC.newsImage.sd_setImage(with: URL(string: element.image))
                    sheetNewsVC.newsUrl = element.link
                }
                self.showBlur(IsHidden: false)
                
            }.disposed(by: bag)
       
        
    }
   
    private func registerCells(){
        TopRated.register(UINib(nibName: "TopRatedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedCollectionViewCell")
        metaCritic.register(UINib(nibName: "MetaCriticCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MetaCriticCollectionViewCell")
        newsCollection.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsCollectionViewCell")
    }
   
    @IBAction func categoryButtonClicked(_ sender: Any) {
        let categoryVC = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        
        categoryVC.title = "POPULAR GAMES"
        self.navigationController?.pushViewController(categoryVC, animated: true)
 
    }
    @IBAction func ratedButtonClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "fromHometoCategory", sender: nil)
    }

}


