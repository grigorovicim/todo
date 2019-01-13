//
//  TodoReusableTableViewCell.swift
//  todoapp
//
//  Created by Monica Grigorovici on 11/3/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class TodoReusableTableViewCellItem: NSObject {
    var title = ""
    var info = ""
    var leftImageName = ""
    var rightImageName = "right_arrow"
    var options = [AnyObject]()
    
    var selection: AnyObject?
    
    init(title: String, info: String , leftImageName: String? = nil, rightImageName: String? = nil, options: [AnyObject]? = nil) {
        super.init()
        
        self.title = title
        self.info = info
        self.leftImageName = leftImageName ?? ""
        self.rightImageName = rightImageName ?? ""
        self.options = options ?? [AnyObject]()
    }
    
    private func setupProperties(title: String, info: String , leftImageName: String) {
        self.title = title
        self.info = info
        self.leftImageName = leftImageName
    }
}

class TodoReusableTableViewCell: UITableViewCell {
    static let reuseIdentifier = "TodoReusableTableViewCellIdentifier"
    
    @IBOutlet weak private var upperSeparatorView: UIView!
    @IBOutlet weak private var lowerSeparatorView: UIView!
    
    @IBOutlet weak private var leftImageView: UIImageView!
    @IBOutlet weak private var rightImageView: UIImageView!
    
    @IBOutlet weak private var titleTextLabel: UILabel!
    @IBOutlet weak private var infoTextLabel: UILabel!
    
    var leftImageColor: UIColor = .clear {
        didSet {
            self.leftImageView.backgroundColor = leftImageColor
            self.leftImageView.layer.cornerRadius = self.leftImageView.frame.width / 2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.upperSeparatorView.backgroundColor = UIColor.init(rgb: 0x3D3D3D)
        self.lowerSeparatorView.backgroundColor = UIColor.init(rgb: 0x3D3D3D)
        self.upperSeparatorView.isHidden = true
    }
    
    public var leftImageName = "" {
        didSet {
            self.leftImageView.image = UIImage.init(named: leftImageName)
            self.setupImageView(self.leftImageView)
        }
    }
    
    public var rightImageName = "" {
        didSet {
            self.rightImageView.image = UIImage.init(named: rightImageName)
            self.setupImageView(self.rightImageView)
        }
    }
    
    public var hideUpperSeparator = false {
        didSet {
            self.upperSeparatorView.isHidden = self.hideUpperSeparator
        }
    }
    
    public var hideLowerSeparator = false {
        didSet {
            self.lowerSeparatorView.isHidden = self.hideLowerSeparator
        }
    }
    
    public var title = "" {
        didSet {
            self.titleTextLabel.text = self.title
        }
    }
    
    public var info = "" {
        didSet {
            self.infoTextLabel.text = self.info
        }
    }
    
    private func setupImageView(_ imageView: UIImageView) {
        imageView.tintColor = .white
        imageView.contentMode = .scaleToFill
    }
    
    public func setup(leftImageName: String,
                      title: String,
                      info: String,
                      rightImageName: String) {
        self.leftImageName = leftImageName
        self.title = title
        self.info = info
        self.rightImageName = rightImageName
    }
}
