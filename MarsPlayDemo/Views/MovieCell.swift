//
//  MovieCell.swift
//  MarsPlayDemo
//
//  Created by Pawan Joshi on 11/12/18.
//  Copyright © 2018 Pawan Joshi. All rights reserved.
//

import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

class MovieCell: UICollectionViewCell {

    static let cellIdentifier: String = className
    static let xibName: String = className
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    weak var parentViewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(movie: Movie) {
        posterImageView.sd_setImage(with: URL(string: movie.poster ?? ""), placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
        titleLabel.text = movie.title
        yearLabel.text = movie.yearTimestamp
        typeLabel.text = movie.type
    }
    
    @IBAction fileprivate func posterImageViewTapped(_ sender: UIButton) {
        if let image = posterImageView.image {
            let imageInfo = JTSImageInfo()
            imageInfo.image = image
            imageInfo.referenceRect = sender.frame
            imageInfo.referenceView = sender.superview
            let imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: JTSImageViewControllerMode.image, backgroundStyle: JTSImageViewControllerBackgroundOptions.scaled)
            imageViewer?.show(from: parentViewController, transition: JTSImageViewControllerTransition.fromOriginalPosition)
        }
    }
    
}
