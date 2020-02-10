

import UIKit

internal final class PopoverCell: UITableViewCell {
    static let identifier: String = "PopoverCell"

    fileprivate let contentLabel: UILabel = {
        let label = UILabel()
        label.font = CellLabelFont
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUserInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupUserInterface() {
        separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        backgroundColor = UIColor.clear
        
        contentView.addSubview(contentLabel)
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "|-\(Leading)-[contentLabel]-\(Leading)-|",
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: ["contentLabel": contentLabel]
            )
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[contentLabel]-0-|",
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: ["contentLabel": contentLabel]
            )
        )
    }
    
    func setupData(_ data: PopoverItem) {
        contentLabel.text = data.title
        if let textColor = data.textColor {
            contentLabel.textColor = textColor
        }
        
        contentView.backgroundColor = data.coverColor ?? UIColor.white
    }

#if DEBUG
    deinit {
        debugPrint("\(#file):\(#line):\(type(of: self)):\(#function)")
    }
#endif
}


final class PopoverWihtImageCell: UITableViewCell {
    static let identifier: String = "PopoverWihtImageCell"
    
    internal let contentLabel: UILabel = {
        let label = UILabel()
        label.font = CellLabelFont
        label.lineBreakMode = .byCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    internal let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.clear
        imageView.frame.size = CGSize(width: 50, height: 50)
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupUserInterface() {
        separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        backgroundColor = UIColor.clear
        
        contentView.addSubview(contentLabel)
        contentView.addSubview(leftImageView)
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "|-\(Leading)-[leftImageView(\(ImageWidth))]-\(Spacing)-[contentLabel]-\(Leading)-|",
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: ["contentLabel": contentLabel, "leftImageView": leftImageView]
            )
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[contentLabel]-0-|",
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: ["contentLabel": contentLabel]
            )
        )
        contentView.addConstraint(
            NSLayoutConstraint(
                item: leftImageView,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: contentLabel,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
        )
    }
    
    func setupData(_ data: PopoverItem) {
        contentLabel.text = data.title
        if let textColor = data.textColor {
            contentLabel.textColor = textColor
        }
        leftImageView.image = data.image
        contentView.backgroundColor = data.coverColor ?? UIColor.white
    }

#if DEBUG
    deinit {
        debugPrint("\(#file):\(#line):\(type(of: self)):\(#function)")
    }
#endif
}


