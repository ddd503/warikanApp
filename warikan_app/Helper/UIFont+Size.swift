//
//  UIFont+Size.swift
//  warikan_app
//
//  Created by kawaharadai on 2018/04/22.
//  Copyright © 2018年 dai kawahara. All rights reserved.
//

import UIKit

extension UIFont {
    static var main_text: CGFloat {
        if (UIScreen.main.bounds.width >= 414.0) {
            return 21
        } else if (UIScreen.main.bounds.width >= 375.0) {
            return 20
        } else {
            return 17
        }
    }
    
    static var main_text2: CGFloat {
        if (UIScreen.main.bounds.width >= 414.0) {
            return 23
        } else if (UIScreen.main.bounds.width >= 375.0) {
            return 22
        } else {
            return 19
        }
    }
    
    static var text_field: CGFloat {
        
        if (UIScreen.main.bounds.width >= 414.0) {
            return 19
        } else if (UIScreen.main.bounds.width >= 375.0) {
            return 17
        } else {
            return 15
        }
    }
    
    static var long_text: CGFloat {
        
        if (UIScreen.main.bounds.width >= 414.0) {
            return 18
        } else if (UIScreen.main.bounds.width >= 375.0) {
            return 17
        } else {
            return 14
        }
    }
}
