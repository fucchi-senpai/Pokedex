//
//  NavigationViewController.swift
//  
//
//  Created by Shota Fuchikami on 2022/02/16.
//

import UIKit

public class NavigationViewController: UINavigationController {
    
    // MARK: Field Property
    
    private lazy var navigationTitle: String? = {
        switch visibleViewController {
        case is HomeViewController:
            return "Pokemon"
        default:
            return nil
        }
    }()
    
    // MARK: Initializer
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lify Cycle
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        visibleViewController?.navigationItem.title = navigationTitle
        navigationBar.prefersLargeTitles = true
    }

}
