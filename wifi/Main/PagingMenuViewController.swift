//
//  PagingMenuViewController.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 5/17/16.
//  Copyright © 2016 kitasuke. All rights reserved.
//

import UIKit
import Foundation
import PagingMenuController

let menuBackgroundColor : UIColor! = .white
let menuUnderlineColor : UIColor! = .cyan

struct MenuItemStatus: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
        let title = MenuItemText(text: "Status")
        return .text(title: title)
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
    
    var selectedBackgroundColor: UIColor {
        return menuBackgroundColor
    }
}

struct MenuItemRequests: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
        let title = MenuItemText(text: "Requests")
        return .text(title: title)
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
            return .underline(height: 5, color: menuUnderlineColor, horizontalPadding: 0, verticalPadding: 0)
        }
        var height: CGFloat {
            return 40
        }
        var backgroundColor: UIColor {
            return menuBackgroundColor
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


