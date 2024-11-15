//
//  ViewController.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    //MARK: - Public properties
    
    //MARK: - Private properties
    private let photoPicker: PhotoPicker
    
    private var height: CGFloat {
        view.frame.height
    }
    
    private var width: CGFloat {
        view.frame.width
    }
    
    private let editedViewDefaultSize = CGSize(width: 200, height: 200)
    
    //MARK: - Views
//    private lazy var rect: UIView = {
//        let view = UIView(frame: .init(x: 30, y: 30, width: 100, height: 100))
//        view.backgroundColor = .systemRed
//        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(longPressGesture))
//        panGesture.maximumNumberOfTouches = 1
//        
//        view.addGestureRecognizer(panGesture)
//        return view
//    }()
    
    private lazy var addImageButtonImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus.circle"))
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.addSubview(addImageButtonImageView)
        button.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        button.isHidden = false
        return button
    }()
    
    private lazy var editedView: EditedView = {
        let view = EditedView()
        view.isHidden = true
        return view
    }()
    
    private lazy var segmentedControlImageMode: UISegmentedControl = {
        
        let control = UISegmentedControl(items: [
            UIAction(title: "original") { _ in
                
            },
            
            UIAction(title: "Monochrome") { _ in
                
            }
        ])
        control.selectedSegmentIndex = 0
        control.isEnabled = false
        return control
    }()
    
    //MARK: - Life Cycle
    init(photoPicker: PhotoPicker) {
        self.photoPicker = photoPicker
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        testSetup()
    }
    
    //MARK: - Public methods
}

//MARK: - Private methods
private extension HomeViewController {
    func setupView() {
        view.addSubview(addImageButton)
        view.addSubviews(editedView, segmentedControlImageMode)
        
        photoPicker.delegate = self
    }
    
    func setupConstraints() {
        addImageButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        addImageButtonImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        segmentedControlImageMode.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(50)
        }
    }
    
    @objc func addImage() {
        photoPicker.present()
    }
    
    func setEditedImage(_ image: UIImage?) {
        
        editedView.setImage(image)
        editedView.setBorder(width: 2, color: .systemYellow)
        editedView.moveToCenterInSuperview()
        editedView.isHidden = false
        editedView.bounds.size = editedViewDefaultSize
        
        addImageButton.isHidden = true
        
        segmentedControlImageMode.isEnabled = true
    }
    
    func setupNavigationItem() {
        navigationItem.title = "Home"
    }
    
    func testSetup() {
        setEditedImage(.image1)
    }
}

extension HomeViewController: PhotoPickerDelegate {
    func picker(_ picker: any PhotoPicker, didSelect image: UIImage) {
        setEditedImage(image)
    }
    
}

#Preview {
    makeController()
}
