//
//  EmptyView.swift
//  RemoteRecruit
//
//  Created by rmehla on 07/06/26.
//

import UIKit

class EmptyStateView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    private static let tag = 9999
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("EmptyStateView", owner: self,
                                 options: nil)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
       
    // MARK: - Show
    static func show(on parentView: UIView) {
        hide(from: parentView)
        
        let emptyView = EmptyStateView(frame: parentView.bounds)
        emptyView.tag = tag
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(emptyView)
        parentView.isHidden = false
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: parentView.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])
    }

    // MARK: - Hide
    static func hide(from parentView: UIView) {
        parentView.viewWithTag(tag)?.removeFromSuperview()
        parentView.isHidden = true
    }
}
