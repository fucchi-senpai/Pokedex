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
    // TODO: Implementaion ViewModelProtocol
    private weak var delegate: HomeViewDelegate?
    
    required convenience init() {
        self.init(nibName: nil, bundle: nil)
        delegate = self
    }
    
    // MARK: Lify Cycle
    
    public override func loadView() {
        delegate?.initView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.reloadData()
    }

}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCell.cellIdentifier, for: indexPath)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
}

// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    public func initView() {
        view = homeView
        navigationItem.title = "Pokedex"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    public func reloadData() {
        homeView.collectionView.reloadData()
    }
}
