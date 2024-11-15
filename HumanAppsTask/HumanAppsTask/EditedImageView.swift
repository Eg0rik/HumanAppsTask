//
//  EditedView.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit
import SnapKit


class EditedImageView: MovableView {
    
    //MARK: - Public properties
    
    //MARK: - Private properties
    
    //MARK: - Views
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
}

//MARK: - Private methods
private extension EditedImageView {
    func setupView() {
        addSubview(imageView)
        
        setupGestures()
        setupConstraints()
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

#Preview {
    makeController()
}
