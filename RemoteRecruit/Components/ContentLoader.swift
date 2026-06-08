//
//  ContentLoader.swift
//  RemoteRecruit
//
//  Created by rmehla on 07/06/26.
//

import UIKit

class ContentLoader: UIView {
    @IBOutlet weak var activity: UIActivityIndicatorView!
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
        Bundle.main.loadNibNamed("ContentLoader", owner: self,
                                 options: nil)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
       
    // MARK: - Show
    static func show(on parentView: UIView) {
        hide(from: parentView)
        
        let loaderView = ContentLoader(frame: parentView.bounds)
        loaderView.tag = tag
        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(loaderView)
        parentView.isHidden = false
        loaderView.activity.startAnimating()
        
        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: parentView.topAnchor),
            loaderView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            loaderView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])
    }

    // MARK: - Hide
    static func hide(from parentView: UIView) {
        if let loaderView = parentView.viewWithTag(tag) as? ContentLoader {
            loaderView.activity.stopAnimating()
            loaderView.removeFromSuperview()
        }
        parentView.isHidden = true
    }
}
