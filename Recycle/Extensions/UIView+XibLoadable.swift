//
//  UIView+XibLoadable.swift
//  Recycle
//
//  Created by Babaev Mikhail on 16.10.2020.
//

import UIKit

protocol XibLoadable: UIView {
    
    var contentView: UIView! { get }
    
    func initXib()
}

extension XibLoadable {
    
    func initXib() {
        let typeDescribing = type(of: self)
        let nibName = String(describing: typeDescribing)
        let bundle = Bundle(for: typeDescribing)
        let nib = UINib(nibName: nibName, bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        addContentViewConstraints()
    }
    
    private func addContentViewConstraints() {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: contentView.topAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
