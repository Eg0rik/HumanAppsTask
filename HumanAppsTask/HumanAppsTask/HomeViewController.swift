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
    
    private let editedViewDefaultSize = CGSize(width: 200, height: 200)
    private let editedViewDefaultBorderColor = UIColor.systemYellow
    private let editedViewDefaultBorderWidth: CGFloat = 10
    
    
    //MARK: - Views
    private lazy var editedView: EditedImageView = {
        let view = EditedImageView()
        view.isHidden = true
        return view
    }()
    
    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .brandLightGray
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
    
    private lazy var colorPicker: UIColorPickerViewController = {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "Frame color"
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        return colorPicker
    }()
    
    private lazy var borderWidthSlider: UISlider = {
        let slider = UISlider()
        slider.value = 16
        slider.minimumValue = 0
        slider.maximumValue = 20
        slider.thumbTintColor = editedViewDefaultBorderColor
        slider.minimumTrackTintColor = editedViewDefaultBorderColor
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .allEvents)
        return slider
    }()
    
    //MARK: - Life Cycle
    init(photoPicker: PhotoPicker) {
        self.photoPicker = photoPicker
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
        deactivateEditPanel()
        setupConstraints()
        testSetup()
    }
    
    //MARK: - Public methods
}

//MARK: - Private methods
private extension HomeViewController {
    func setupView() {
        view.addSubviews(editedView, topBackgroundView, segmentedControlImageMode, borderWidthSlider)
        
        photoPicker.delegate = self
    }
    
    func setupTabBarItem() {
        tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "scribble"),
            selectedImage: UIImage(systemName: "scribble.variable")
        )
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertVC, animated: true)
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Home"
    }
    
    func activateEditPanel() {
        segmentedControlImageMode.isEnabled = true
        setBarButtonWithEditingMenu()
    }
    
    func deactivateEditPanel() {
        segmentedControlImageMode.isEnabled = false
        setPlussBarButton()
    }
    
    func setBarButtonWithEditingMenu() {
        let menu = UIMenu(title: "Options", children: [
            UIAction(title: "Set a default size") { [weak self] action in
                guard let self else { return }
                
                self.editedView.moveToCenterInSuperview()
                self.editedView.transform = .identity
            },
            
            UIAction(title: "Choose new frame color",image: UIImage(systemName: "pencil.tip")) { [weak self] action in
                guard let self else { return }
                
                self.present(self.colorPicker, animated: true)
            },
            
            UIAction(title: "Save the image",image: UIImage(systemName: "square.and.arrow.down.fill")) { [weak self] action in
                self?.saveImage()
            },
            
            UIAction(title: "Delete the image",image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] action in
                self?.deleteImage()
            }
        ])
        
        let rightButton = UIBarButtonItem(
            title: nil,
            image: UIImage(systemName: "slider.horizontal.3"),
            target: nil,
            action: nil,
            menu: menu)
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    // Button to add image from photo library.
    func setPlussBarButton() {
        let rightButton = UIBarButtonItem(
            title: nil,
            image: .add,
            target: self,
            action: #selector(addImage))
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func addImage() {
        photoPicker.present()
    }
    
    func setupConstraints() {
        topBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(borderWidthSlider.snp.bottom).offset(10)
        }
        
        segmentedControlImageMode.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(40)
        }
        
        borderWidthSlider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(segmentedControlImageMode.snp.bottom).offset(20)
        }
    }
    
    func setEditedImage(_ image: UIImage?) {
        editedView.setImage(image)
        editedView.moveToCenterInSuperview()
        editedView.isHidden = false
        editedView.bounds.size = editedViewDefaultSize
        editedView.setBorder(width: editedViewDefaultBorderWidth, color: editedViewDefaultBorderColor)
        
        activateEditPanel()
    }
    
    func deleteImage() {
        editedView.delteImage()
        editedView.isHidden = true
        
        deactivateEditPanel()
    }
    
    func saveImage() {
        guard let image = editedView.getImage() else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_ : didFinishSavingWithError: contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        let message = error?.localizedDescription ?? "success"
        
        showAlert(title: "Saving image to galery ends with:", message: message)
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider) {
        editedView.layer.borderWidth = CGFloat(sender.value)
    }
}

//MARK: PhotoPickerDelegate
extension HomeViewController: PhotoPickerDelegate {
    func picker(_ picker: any PhotoPicker, didSelect image: UIImage) {
        setEditedImage(image)
    }
}

//MARK: UIColorPickerViewControllerDelegate
extension HomeViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ colorPicker: UIColorPickerViewController, didSelect: UIColor, continuously: Bool) {
        colorPicker.dismiss(animated: true)
        
        editedView.layer.borderColor = didSelect.cgColor
        
        borderWidthSlider.thumbTintColor = didSelect
        borderWidthSlider.minimumTrackTintColor = editedViewDefaultBorderColor
    }
}

//FIXME: - For tests
private extension HomeViewController {
    func testSetup() {
        setEditedImage(.image1)
    }
}

#Preview {
    makeController()
}
