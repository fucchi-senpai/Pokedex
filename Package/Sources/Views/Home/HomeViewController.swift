//
//  HomeViewController.swift
//  
//
//  Created by Shota Fuchikami on 2022/02/12.
//

import UIKit
import Models

// MARK: - UIViewController
public class HomeViewController: UIViewController {
    
    // MARK: Field Property
    
    private lazy var homeView: HomeView = .init(viewController: self)
    
    private var model: Response? = nil
    private var client: PokeAPIProtocol? = nil
    
    // MARK: Initializer
        
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.client = PokeAPIRepository()
    }
    
    // MARK: Lify Cycle
    
    public override func loadView() {
        view = homeView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        homeView.collectionView.reloadData()
        client?.fetch(from: "https://pokeapi.co/api/v2/pokemon?limit=151", success: { (response: Response?) in
            self.model = response
            self.homeView.collectionView.reloadData()
        }, failure: { (error: Error) in
            let alert = UIAlertController(title: "ネットワークエラー", message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: .none)
            alert.addAction(action)
            DispatchQueue.main.async {
                self.present(alert, animated: false, completion: nil)
            }
        })
    }

}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.results.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCell.cellIdentifier, for: indexPath)
        if let cell = cell as? HomeViewCell {
            cell.label.text = model?.results[indexPath.row].name
            cell.imageView.image = UIImage(systemName: "person")
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
