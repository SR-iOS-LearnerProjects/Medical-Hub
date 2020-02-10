

import UIKit

public extension UIViewController {    
    public func popover(_ controller: PopoverController) {
        func assertFromView(_ fromView: UIView) {
            var view: UIView? = fromView
            while (nil != view) {
                if view == view {
                    return
                } else {
                    view = view?.superview
                }
            }
            
            fatalError("fromView: \(fromView) must be descendant of self.view")
        }
        
        assertFromView(controller.fromView)
                
        let popoverView = PopoverView(controller, commonSuperView: view)
        popoverView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popoverView)
        self.popoverView = popoverView
        
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "|[popoverView]|",
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: ["popoverView": popoverView]
            )
        )
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[popoverView]|",
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: ["popoverView": popoverView]
            )
        )

        popoverView.addConstraints()        
    }
    
    public func dismissPopover() {
        self.popoverView?.dismiss()
    }
    
    public var popoverDidAppear: Bool {
        return nil != popoverView?.superview
    }
}
