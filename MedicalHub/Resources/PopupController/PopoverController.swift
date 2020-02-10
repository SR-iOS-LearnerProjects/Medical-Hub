//

import UIKit

public final class PopoverController {
    internal let items: [PopoverItem]
    internal let fromView: UIView
    internal let direction: Direction
    internal let reverseHorizontalCoordinates: Bool
    internal let style: PopoverStyle
    internal let initialIndex: Int
    internal var dismissHandler: (() -> ())?

    public var coverColor: UIColor? {
        didSet {
                 self.items.forEach { (item: PopoverItem) -> () in
                    item.coverColor = self.coverColor
        }
    }
        }
    public var textColor: UIColor? {
        didSet {
                self.items.forEach { (item: PopoverItem) -> () in
                    item.textColor = textColor
        }
    }
    }
    public init(
        items: [PopoverItem],
        fromView: UIView,
        direction: Direction = .down,
        reverseHorizontalCoordinates: Bool = false,
        style: PopoverStyle = .normal,
        initialIndex: Int = 0,
        dismissHandler: (() -> ())? = nil)
    {
        if 0 > initialIndex || initialIndex >= items.count {
            fatalError("initialIndex(\(initialIndex)) out of boundary.")
        }
        self.items = items
        self.fromView = fromView
        self.direction = direction
        self.reverseHorizontalCoordinates = reverseHorizontalCoordinates
        self.style = style
        self.initialIndex = initialIndex
        self.dismissHandler = dismissHandler
    }
    
#if DEBUG
    deinit {
        debugPrint("\(#file):\(#line):\(type(of: self)):\(#function)")
    }
#endif
}
