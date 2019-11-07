//
//  DeliverableCell.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 06/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import UIKit
import SDWebImage

class DeliverableCell : UITableViewCell {
    
    var deliverable : Deliverable? {
        didSet {
            deliverableImage.sd_setImage(with: URL(string: (deliverable?.imageUrl ?? nil) ?? ""), completed: nil)
            deliverableDescriptionLabel.text = deliverable?.description
        }
    }
    
    private let deliverableDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let deliverableImage : UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 60, height: 60.0))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(deliverableImage)
        addSubview(deliverableDescriptionLabel)
        
        deliverableImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 60, height: 0, enableInsets: false)
        deliverableDescriptionLabel.anchor(top: topAnchor, left: deliverableImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: frame.size.width - 60 - 10, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
