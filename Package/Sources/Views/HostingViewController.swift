//
//  HostingViewController.swift
//
//
//  Created by Shota Fuchikami on 2021/12/06.
//

import Models
import SwiftUI
import UIKit

// MARK: HostingControllerDelegate

public protocol HostingViewControllerDelegate: AnyObject {
    func initViews()
}

// MARK: UIViewController

public class HostingViewController: UIViewController {
    // MARK: Field Variable

    fileprivate var hostingController: UIViewController
    fileprivate weak var delegate: HostingViewControllerDelegate?

    // MARK: Initialiser

    public init<T: View>(swiftUiView: T) {
        hostingController = UIHostingController(rootView: swiftUiView)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UIViewController LifeCycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        delegate?.initViews()
    }
}

// MARK: Implement HostingControllerDelegate

extension HostingViewController: HostingViewControllerDelegate {
    public func initViews() {
        view.backgroundColor = .systemBackground
        initNavigationView()
        initHostingView()
    }
}

// MARK: Private methods

extension HostingViewController {
    private func initNavigationView() {
        navigationItem.title = "Pokedex"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }

    private func initHostingView() {
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
