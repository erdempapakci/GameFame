//
//  DetailViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 7.10.2022.
//

import UIKit
import SDWebImage
import RxSwift
import AVFoundation
import AVKit
final class DetailViewController: UIViewController, UIScrollViewDelegate {
   
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var publisherLbl: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var developerName: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var trailersCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    private var network = NetworkService()
    private var bag = DisposeBag()
    
    var slug = String()
    var url = String()
    var trailer = [GameTrailer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        bindingUI()
        bindingGenresCollectionView()
        bindingImageCollectionView()
        bindingTrailerCollectionView()
        bindPlatform()
       
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 6
    }
  
    @IBAction func storeButtonClicked(_ sender: Any) {
        if let url = URL(string: self.url) {
            UIApplication.shared.open(url, completionHandler: nil)
        }
    }

   private func bindingUI() {
       
        network.fetchGameDetails(gameID: slug)
        network.detailBehavior.bind { gamedetail in
            self.gameName.text = gamedetail.name
            self.websiteLbl.text = gamedetail.website
            self.developerName.text = gamedetail.developers.first?.name
            self.descriptionLbl.text = gamedetail.description_raw
            self.releaseDate.text = gamedetail.released
            self.publisherLbl.text = gamedetail.publishers.first?.name
            self.ratingLbl.text = "\(String(describing: gamedetail.rating))"
            self.mainImage.sd_setImage(with: URL(string: gamedetail.background_image!))
        }.disposed(by: bag)
    
    }
    
    private func bindPlatform() {
        network.fetchGameStores(gameID: slug)
        network.platformsBehavior.bind { platforms in
            self.url = platforms.first!.url
        
        }.disposed(by: bag)
        
    }
   
    
   private func bindingImageCollectionView() {
        network.fetchGameScreenShots(gameID: slug)
        imageCollectionView.rx.setDelegate(self).disposed(by: bag)
        network.screenShotBehavior.bind(to: imageCollectionView.rx.items(cellIdentifier: "ScreenShotCollectionViewCell",cellType: ScreenShotCollectionViewCell.self)) {
            section,item,cell in
            
            cell.SSImage.sd_setImage(with: URL(string: item.image))
            
        }.disposed(by: bag)
     
    }
    
    private func bindingTrailerCollectionView() {
         network.fetchGameTrailers(gameID: slug)
         trailersCollectionView.rx.setDelegate(self).disposed(by: bag)
         network.trailerBehavior.bind(to: trailersCollectionView.rx.items(cellIdentifier: "TrailersCollectionViewCell",cellType: TrailersCollectionViewCell.self)) {
             section,item,cell in
             if section == 11 {
                 cell.playButton.isHidden = true
             }
         }.disposed(by: bag)
    
     }
 
    @IBAction func backButtonClicked(_ sender: Any) {
    
    
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
    
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    private func bindingGenresCollectionView() {
      
        network.fetchGameDetails(gameID: slug)
        genresCollectionView.rx.setDelegate(self).disposed(by: bag)
        
        network.genresBehavior.bind(to: genresCollectionView.rx.items(cellIdentifier: "GenresCollectionViewCell", cellType: GenresCollectionViewCell.self)) {
            section, item, cell in
            cell.genreLabel.text = item.name
            print(item.name)
            
        }.disposed(by: bag)
     }
    
   private func registerCells(){
        imageCollectionView.register(UINib(nibName: "ScreenShotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenShotCollectionViewCell")
       trailersCollectionView.register(UINib(nibName: "TrailersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TrailersCollectionViewCell")
       genresCollectionView.register(UINib(nibName: "GenresCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenresCollectionViewCell")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.imageCollectionView.contentOffset, size: self.imageCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.imageCollectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
  
}
