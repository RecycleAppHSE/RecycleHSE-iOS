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
    
    var sectionInsets = UIEdgeInsets(
        top: 12,
        left: 12,
        bottom: 12,
        right: 12
    )
    
    var itemSpacing: CGFloat = 10
    var size: CGSize = .init(width: 70, height: 70)
    var textFont: UIFont = .systemFont(ofSize: 13, weight: .semibold)
    
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
        self.cellModels = cellModels.filter { !$0.type.isUnknown }
        collectionView.reloadData()
        
        collectionView.invalidateIntrinsicContentSize()
        invalidateIntrinsicContentSize()
        heightConstraint.constant = collectionView.contentSize.height
        collectionView.reloadData()
    }
    
    func setupSmall() {
        size = CGSize(width: 40, height: 40)
        itemSpacing = 4
        sectionInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
        textFont = .systemFont(ofSize: 8, weight: .semibold)
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
        
        cell.textLabel.font = textFont
        cell.configure(with: cellModel)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension WasteTypesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        let cellModel = cellModels[row]
        guard cellModel.mode == .selectable ||
                cellModel.mode == .selectableBlue else {
            return
        }
        let type = cellModel.type
        
        if !cellModel.isSelected {
            selectedTypes.append(type)
        } else {
            selectedTypes.removeAll(where: { $0 == type })
        }
        
        cellModels[row] = WasteTypeCellModel(
            waste: cellModel.type,
            isSelected: !cellModel.isSelected,
            mode: cellModel.mode
        )
        
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
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
        itemSpacing
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
        collectionView.isScrollEnabled = false
        
        let cellNib = UINib(nibName: "WasteTypeCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "WasteTypeCell")
        
        heightConstraint.priority = .fittingSizeLevel
    }
}
