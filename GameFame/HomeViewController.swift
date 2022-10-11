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

    @IBOutlet weak var metaCritic: UICollectionView!
    @IBOutlet weak var gameNewsImage: UIImageView!
    @IBOutlet weak var TopRated: UICollectionView!
    var currentAngle: CGFloat = 0
        var currentOffset: CGFloat = 0
        let transformLayer = CATransformLayer()
    
   
    var slug = String()
    private var network = NetworkService()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        bindingPopular()
        bindingMetaCritic()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                view.addGestureRecognizer(panGesture)
                
                transformLayer.frame = view.bounds
                view.layer.addSublayer(transformLayer)
            let _ = "https://media.rawg.io/media/games/736/73619bd336c894d6941d926bfd563946.jpg"
                    (0...5).forEach { index in
                    addImageCard(name: "steam")
              
                }
       
            
                turnCarosel()
       
    }
    
   
    private func bindingPopular() {
        self.network.fetchPopularGames(url: APIConstants.POPULAR_URL)
        TopRated.rx.setDelegate(self).disposed(by: bag)
        network.popularsBehavior.bind(to: TopRated.rx.items(cellIdentifier: "TopRatedCollectionViewCell",cellType: TopRatedCollectionViewCell.self)) {
            section,item,cell in
            cell.gameImage.sd_setImage(with: <#T##URL?#>)
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
        
    }
  
    private func registerCells(){
        TopRated.register(UINib(nibName: "TopRatedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedCollectionViewCell")
        metaCritic.register(UINib(nibName: "MetaCriticCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MetaCriticCollectionViewCell")
        
    }
   
    @IBAction func categoryButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "fromHometoCategory", sender: nil)
    }
  
    
}


extension HomeViewController {
    
    private func degreeToRadians(degree: CGFloat) -> CGFloat {
           return (degree * CGFloat.pi) / 180
       }
       
       private func addImageCard(name: String) {
           
           let cardSize = CGSize(width: 200, height: 300)
           let imageLayer = CALayer()
           let origin = CGPoint(x: (view.bounds.width / 2) - (cardSize.width / 2),
                                y: (view.bounds.height / 2) - (cardSize.height / 2))
           imageLayer.frame = CGRect(origin: origin, size: cardSize)
           
           guard let cardImage = UIImage(named: name)?.cgImage else { return }
           imageLayer.contents = cardImage
           imageLayer.contentsGravity = .resizeAspectFill
           imageLayer.borderColor = UIColor.lightGray.cgColor
           imageLayer.borderWidth = 3.0
           imageLayer.cornerRadius = 8
           imageLayer.masksToBounds = true
           imageLayer.isDoubleSided = true
           transformLayer.addSublayer(imageLayer)
       }
       
       private func turnCarosel() {
           
           guard let transformSubLayers = transformLayer.sublayers else { return }
           
           let segmentForImageCard = CGFloat(360 / transformSubLayers.count)
           var angleOffset = currentAngle
           
           transformSubLayers.forEach { (layer) in
               
               var transform = CATransform3DIdentity
               transform.m34 = -1 / 500
               transform = CATransform3DRotate(transform, degreeToRadians(degree: angleOffset), 0, 1, 0)
               transform = CATransform3DTranslate(transform, 0, 0, 200)
               
               CATransaction.setAnimationDuration(0)
               
               layer.transform = transform
               
               angleOffset += segmentForImageCard
           }
       }

       @objc private func handlePan(_ gestureRecognier: UIPanGestureRecognizer) {
           
           let xOffset = gestureRecognier.translation(in: view).x
           
           if gestureRecognier.state == .began {
               currentOffset = 0
           }
           
           let xDifference = xOffset * 0.6 - currentOffset
           currentOffset += xDifference
           currentAngle += xDifference
           
           turnCarosel()
       }
    
    
}
