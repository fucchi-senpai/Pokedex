//
//  HomeViewController.swift
//  
//
//  Created by Shota Fuchikami on 2022/02/12.
//

import UIKit

// MARK: - UIViewController
public class HomeViewController: UIViewController {
    
    // MARK: Field Property
    
    private lazy var homeView: HomeView = .init(viewController: self)
    
    // MARK: Lify Cycle
    
    public override func loadView() {
        view = homeView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        homeView.collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCell.cellIdentifier, for: indexPath)
        if let cell = cell as? HomeViewCell {
            cell.label.text = "Number: \(indexPath.row)"
            cell.imageView.image = UIImage(systemName: "questionmark.circle")
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
}
