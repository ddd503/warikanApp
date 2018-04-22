//
//  Calculation.swift
//  warikan_app
//
//  Created by kawaharadai on 2018/04/22.
//  Copyright © 2018年 dai kawahara. All rights reserved.
//

import Foundation

final class Calculation {
    /// 999以下なら10の位から切り上げ、1000以上なら100の位から切り上げ
    static func round_up(value: Double) -> Double {
        if value < 1000 {
            return ceil(value / 100) * 100
        } else {
            return ceil(value / 100) * 100
        }
    }
    
    /// 数値を3桁ごとにカンマを入れた形(string型)で出力する
    static func add_comma(value: Double) -> String {
        // NSNumber型に変換
        let add_comma_place = NSNumber(value: value)
        // カンマを入れる設定を作成
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        
        // 作成した設定を適用させる
        guard let addCommaValue = formatter.string(from: add_comma_place) else {
            print("カンマの追加に失敗")
            return "\(value)"
        }
        return addCommaValue
    }
}
