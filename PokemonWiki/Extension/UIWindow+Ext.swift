//
//  UIWindow+Ext.swift
//  PokemonWiki
//
//  Created by Elvis Cheng on 3/7/2024.
//

import Foundation
import UIKit

extension UIWindow {
    static var keySafeAreaTop: CGFloat {
        let top = keySafeAreaInsets.top
        return top == 0 ? 20 : top
    }
    
    static var keySafeAreaBottom: CGFloat {
        return keySafeAreaInsets.bottom
    }
    
    static var keySafeAreaInsets: UIEdgeInsets {
        let keyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .last { $0.isKeyWindow }
        
        let safeAreaInsets = keyWindow?.safeAreaInsets
        return safeAreaInsets ?? UIEdgeInsets.zero
    }
}

extension UIScreen {
    static var width : CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height : CGFloat {
        return UIScreen.main.bounds.height
    }
}
