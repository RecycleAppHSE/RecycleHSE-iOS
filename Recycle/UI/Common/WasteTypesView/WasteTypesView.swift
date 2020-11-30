//
//  WasteTypesView.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.10.2020.
//

import UIKit
import SnapKit

class WasteTypesView: UIView {
    
    // MARK: - Properties
    
    var selectedTypes: [WasteType] = []
    
    private var layout: UICollectionViewFlowLayout? {
        collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        return UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
    }()
    
    private let heightConstraint = NSLayoutConstraint()
    
    private var cellModels: [WasteTypeCellModel] = []
    
    private let sectionInsets = UIEdgeInsets(
        top: 12,
        left: 12,
        bottom: 12,
        right: 12
    )
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()

        collectionView.invalidateIntrinsicContentSize()
        invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        let layout = collectionView.collectionViewLayout
        let size = layout.collectionViewContentSize
        return size
    }
    
    func configure(with cellModels: [WasteTypeCellModel]) {
        self.cellModels = cellModels
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
    
    
}

// MARK: - UICollectionViewDataSource

extension WasteTypesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = cellModels[indexPath.row]
        let id = cellModel.identifier
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: id,
            for: indexPath
        ) as! WasteTypeCell
        
        cell.configure(with: cellModel)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension WasteTypesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        let cellModel = cellModels[row]
        let type = cellModel.type
        if cellModel.isSelected {
            selectedTypes.append(type)
        } else {
            selectedTypes.removeAll(where: { $0 == type })
        }
        
        self.cellModels = cellModels.map {
            let type = $0.type
            let isSelected = selectedTypes.contains(type)
            WasteTypeCellModel(
                waste: type,
                isSelected: isSelected,
                mode: $0.mode
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
}

// MARK: - Private

private extension WasteTypesView {
    
    func setup() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
        
        let cellNib = UINib(nibName: "WasteTypeCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "WasteTypeCell")
        
        heightConstraint.priority = .fittingSizeLevel
    }
}
