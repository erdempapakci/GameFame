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
    @IBOutlet weak var gamesWithPage: UICollectionView!
    @IBOutlet weak var upComing: UICollectionView!
    private var viewModel = HomeViewModel()
    
    var slug = String()
    private var bag = DisposeBag()
    
    private var  IsHidden = false
    private var pageNumber = 1
    
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
        bindingUpComing()
        bindingGamesWithPage(pageNumber: 1)
        
        
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
  

    @objc func methodOfReceivedNotification(notification: NSNotification) {
        self.IsHidden = true
        showBlur(IsHidden: IsHidden)
    }

    private func showBlur(IsHidden:Bool) {
      
        self.blurEffectView.frame = self.view.bounds
        self.view.addSubview(self.blurEffectView)
        self.blurEffectView.isHidden = IsHidden
        
    }
    
  
    private func registerCells(){
        TopRated.register(UINib(nibName: "TopRatedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedCollectionViewCell")
        metaCritic.register(UINib(nibName: "MetaCriticCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MetaCriticCollectionViewCell")
        newsCollection.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsCollectionViewCell")
        upComing.register(UINib(nibName: "UpcomingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingCollectionViewCell")
        gamesWithPage.register(UINib(nibName: "SearchByPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchByPageCollectionViewCell")
    }
   
    @IBAction func categoryButtonClicked(_ sender: Any) {
        let categoryVC = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        
        categoryVC.title = "POPULAR GAMES"
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(categoryVC, animated: true)
        }
       
 
    }
    @IBAction func ratedButtonClicked(_ sender: Any) {
        
        let categoryVC = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(categoryVC, animated: true)
        }
        
    }

}

// BINDING CELLS

extension HomeViewController {
    private func bindingNews() {
        self.viewModel.fetchNews()
        newsCollection.rx.setDelegate(self).disposed(by: bag)
        viewModel.gameNewsBehavior.bind(to: newsCollection.rx.items(cellIdentifier: "NewsCollectionViewCell",cellType: NewsCollectionViewCell.self)) {
            section,item,cell in
            cell.newsImage.sd_setImage(with: URL(string: item.image))
            cell.stopLoading()
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
    
    private func bindingPopular() {
    
        self.viewModel.fetchPopularGames()
        TopRated.rx.setDelegate(self).disposed(by: bag)
        viewModel.popularsBehavior.bind(to: TopRated.rx.items(cellIdentifier: "TopRatedCollectionViewCell",cellType: TopRatedCollectionViewCell.self)) {
            section,item,cell in
           
            cell.gameName.text = item.name
            cell.gameImage.sd_setImage(with: URL(string: item.background_image))
            cell.stopLoading()
        }.disposed(by: bag)
     
        TopRated.rx.modelSelected(Game.self)
            .subscribe { game in
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                
                detailVC.slug = game.slug
                
                self.navigationController?.pushViewController(detailVC, animated: false)
            }.disposed(by: bag)
        
    }
    private func bindingMetaCritic() {
        
        self.viewModel.fetchMetacriticGames()
        metaCritic.rx.setDelegate(self).disposed(by: bag)
        viewModel.metacriticBehavior.bind(to: metaCritic.rx.items(cellIdentifier: "MetaCriticCollectionViewCell",cellType: MetaCriticCollectionViewCell.self)) {
            section,item,cell in
            
            cell.gameName.text = item.name
            cell.gameImage.sd_setImage(with: URL(string: item.background_image))
            cell.stopLoading()
        }.disposed(by: bag)
        
        
        
        metaCritic.rx.modelSelected(Game.self)
            .subscribe { game in
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                
                
                detailVC.slug = game.slug
                self.navigationController?.pushViewController(detailVC, animated: true)
                
            }.disposed(by: bag)
    
    }
    
    private func bindingUpComing() {
        self.viewModel.fetchUpComingGames()
        viewModel.upcomingBehavior.bind(to: upComing.rx.items(cellIdentifier: "UpcomingCollectionViewCell",cellType: UpcomingCollectionViewCell.self)) {
            section,item,cell in
            
            cell.upComingName.text = item.name
            cell.upComingImage.sd_setImage(with: URL(string: item.background_image))
        
        }.disposed(by: bag)
        
        upComing.rx.modelSelected(Game.self)
            .subscribe { game in
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                
                
                detailVC.slug = game.slug
                self.navigationController?.pushViewController(detailVC, animated: true)
                
            }.disposed(by: bag)
    }
  
    private func bindingGamesWithPage(pageNumber:Int) {
       
        self.viewModel.fetchGamesWithPage(with: pageNumber)
        viewModel.gamePagesBehavior.bind(to: gamesWithPage.rx.items(cellIdentifier: "SearchByPageCollectionViewCell",cellType: SearchByPageCollectionViewCell.self)) {
            section,item,cell in
            cell.gameImage.sd_setImage(with: URL(string: item.background_image))
            cell.titleLabel.text = item.name
            cell.stopLoading()
        }.disposed(by: bag)
        
       
        
        gamesWithPage.rx.willDisplayCell
            .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { (cell, indexPath) in
                        cell.alpha = 0
                        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 180, 0)
                        cell.layer.transform = rotationTransform
                        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options:  .curveEaseIn, animations: {
                            cell.alpha = 1
                            cell.layer.transform = CATransform3DIdentity
                        }, completion: nil)
                     })
                    .disposed(by: bag)
        gamesWithPage.rx.modelSelected(Game.self)
            .subscribe { game in
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
              
                detailVC.slug = game.slug
                self.navigationController?.pushViewController(detailVC, animated: true)
                
            }.disposed(by: bag)
            
         gamesWithPage.rx.didScroll.subscribe { [weak self] _ in
             guard let self = self else { return }
             let offSetY = self.gamesWithPage.contentOffset.y
             let contentHeight = self.gamesWithPage.contentSize.height

             if offSetY > (contentHeight - self.gamesWithPage.frame.size.height) {
                 self.pageNumber += 1
                 self.viewModel.handlePageOfGames(givenPage: self.pageNumber)
             }
         }
         .disposed(by: bag)
    }
 
}
