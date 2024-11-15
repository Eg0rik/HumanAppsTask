//
//  SettingsViewController.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - Public properties
    
    //MARK: - Private properties
    
    //MARK: - Views
    
    //MARK: - Life Cycle
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    
    //MARK: - Public methods
}

//MARK: - Private methods
private extension SettingsViewController {
    func setupView() {
        
    }
    
    func setupTabBarItem() {
        tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "gear.circle"),
            selectedImage: UIImage(systemName: "gear.circle.fill")
        )
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Settings"
    }
}
