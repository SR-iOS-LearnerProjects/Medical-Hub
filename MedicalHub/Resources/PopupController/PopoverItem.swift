

import Foundation
import UIKit
public final class PopoverItem {
    public let title: String
    public let titleColor: UIColor
    public let image: UIImage?
    public let handler: ((PopoverItem) -> Void)?
    var coverColor: UIColor?
    var textColor: UIColor?
    
    public init(title: String, titleColor: UIColor = UIColor.black, image: UIImage? = nil, handler: ((PopoverItem) -> Void)? = nil) {
        self.title = title
        self.titleColor = titleColor
        self.image = image
        self.handler = handler
    }

#if DEBUG
    deinit {
        debugPrint("\(#file):\(#line):\(type(of: self)):\(#function)")
    }
#endif
}
