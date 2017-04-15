//
//  PagingMenuViewController.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 5/17/16.
//  Copyright © 2016 kitasuke. All rights reserved.
//

import UIKit
import PagingMenuController



extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}

let menuBackgroundColor : UIColor! = UIColor.init(red: 27, green: 51, blue: 77)
let menuUnderlineColor : UIColor! = .white

struct MenuItemStatus: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
        let title = MenuItemText(text: "Status")
        return .text(title: title)
    }
    
    var backgroundColor: UIColor {
        return menuBackgroundColor
    }

    var selectedBackgroundColor: UIColor {
        return menuBackgroundColor
    }

}

struct MenuItemProfile: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
        let title = MenuItemText(text: "Profile")
        return .text(title: title)
    }
    
    var backgroundColor: UIColor {
        return menuBackgroundColor
    }
    
    var selectedBackgroundColor: UIColor {
        return menuBackgroundColor
    }
}

struct MenuItemRequests: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
        let title = MenuItemText(text: "Requests")
        return .text(title: title)
    }
    
    var backgroundColor: UIColor {
        return menuBackgroundColor
    }
    
    var selectedBackgroundColor: UIColor {
        return menuBackgroundColor
    }
}

struct PagingMenuOptions: PagingMenuControllerCustomizable {
    let statusViewController = StatusViewController.instantiateFromStoryboard()
    let profileViewController = ProfileViewController.instantiateFromStoryboard()
    let requestsViewController = RequestsViewController.instantiateFromStoryboard()
    
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: [statusViewController, profileViewController, requestsViewController])
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .infinite(widthMode: .fixed(width: 85), scrollingMode: .scrollEnabled)
        }
        var focusMode: MenuFocusMode {
            return .underline(height: 3, color: menuUnderlineColor, horizontalPadding: 0, verticalPadding: 0)
        }
        var height: CGFloat {
            return 40
        }
        var selectedBackgroundColor: UIColor {
            return UIColor.init(red: 27, green: 51, blue: 77)
        }
        var backgroundColor: UIColor {
            return UIColor.init(red: 27, green: 51, blue: 77)
        }
        var animationDuration: TimeInterval {
            return 0.2
        }
        var defaultPage: Int {
            return 0
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemStatus(), MenuItemProfile(), MenuItemRequests()]
        }
    }

}

class PagingMenuViewController: UIViewController {
    var options: PagingMenuControllerCustomizable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        options = PagingMenuOptions()
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.setup(options)
        
//        pagingMenuController.onMove = { state in
//            switch state {
//            case let .willMoveController(menuController, previousMenuController):
//                print("Will Move")
//            case let .didMoveController(menuController, previousMenuController):
//                print("Did Move")
//            case let .willMoveItem(menuItemView, previousMenuItemView):
//                print("Will Move Item")
//            case let .didMoveItem(menuItemView, previousMenuItemView):
//                print("Did Move Item")
//            case .didScrollStart:
//                print("Scroll start")
//            case .didScrollEnd:
//                print("Scroll end")
//            }
//        }
    }
}


