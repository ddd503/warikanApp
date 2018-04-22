//
//  Deform.swift
//  warikan_app
//
//  Created by kawaharadai on 2018/04/22.
//  Copyright © 2018年 dai kawahara. All rights reserved.
//

import UIKit

final class Deform {
    static func corner(view: UIView, radius: CGFloat) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = radius
    }
}
