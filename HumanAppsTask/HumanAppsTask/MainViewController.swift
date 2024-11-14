//
//  ViewController.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Public properties
    
    //MARK: - Private properties
    
    //MARK: - Views
    private lazy var addImageButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    //MARK: - Life Cycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Public methods
}

//MARK: - Private methods
private extension BaseViewController {
    func setupView() {
        
    }
}

#Preview {
    makeTabBarController()
}
