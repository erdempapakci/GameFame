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

class HomeViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var newsCollection: UICollectionView!
    @IBOutlet weak var metaCritic: UICollectionView!
    @IBOutlet weak var TopRated: UICollectionView!
    
   
    var slug = String()
    private var network = NetworkService()
    private var bag = DisposeBag()
    private var effect: UIVisualEffect?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        bindingPopular()
        bindingMetaCritic()
        bindingNews()
    
    }

    private func bindingPopular() {
        self.network.fetchPopularGames(url: APIConstants.POPULAR_URL)
        TopRated.rx.setDelegate(self).disposed(by: bag)
        network.popularsBehavior.bind(to: TopRated.rx.items(cellIdentifier: "TopRatedCollectionViewCell",cellType: TopRatedCollectionViewCell.self)) {
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
        self.network.fetchMetacriticGames(url: APIConstants.METACRITIC_URL)
        metaCritic.rx.setDelegate(self).disposed(by: bag)
        network.metacriticBehavior.bind(to: metaCritic.rx.items(cellIdentifier: "MetaCriticCollectionViewCell",cellType: MetaCriticCollectionViewCell.self)) {
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
    private func bindingNews() {
        self.network.fetchGameNews()
        newsCollection.rx.setDelegate(self).disposed(by: bag)
        network.gameNewsBehavior.bind(to: newsCollection.rx.items(cellIdentifier: "NewsCollectionViewCell",cellType: NewsCollectionViewCell.self)) {
            section,item,cell in
            cell.newsImage.sd_setImage(with: URL(string: item.image))
            
            
        }.disposed(by: bag)
        
        newsCollection.rx.modelSelected(GameNews.self)
            .subscribe { news in
            let storyboard = UIStoryboard(name: "Sheet", bundle: nil)
                let sheetNewsVC =
                storyboard.instantiateViewController(withIdentifier: "SheetViewController") as! SheetViewController
                self.present(sheetNewsVC, animated: true)
                news.map { element in
                    sheetNewsVC.titleLbl.text = element.title
                    sheetNewsVC.descriptionLbl.text = element.welcomeDescription
                    sheetNewsVC.newsImage.sd_setImage(with: URL(string: element.image))
                    sheetNewsVC.newsUrl = element.link
                }
               
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

