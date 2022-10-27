//
//  OnboardingViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 27.10.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let slides : [Slide] = Slide.collection
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPageControl()
    }
    private func setupPageControl() {
        pageControl.numberOfPages = slides.count
        let angle = CGFloat.pi/2
        pageControl.transform = CGAffineTransform(rotationAngle: angle)
        
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        
    }

    private func handleActionButtonTap(at indexPath:IndexPath) {
        if indexPath.item == slides.count - 1 {
            showMainApp()
            
        }else {
            let nextItem = indexPath.item + 1
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
            pageControl.currentPage = nextItem
        }
        
    }
    private func showMainApp() {
        let mainTabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            
            window.rootViewController = mainTabVC
            UIView.transition(with: window,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: nil)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.y / scrollView.frame.size.height)
        pageControl.currentPage = index
    }

}
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoardingCell", for: indexPath) as! OnboardingCollectionViewCell
        let slide = slides[indexPath.item]
        cell.configure(with: slide)
        cell.actionButtonDidTap = { [weak self] in
            self?.handleActionButtonTap(at: indexPath)
        }
        
        
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    
}
