//
//  MainViewController.swift
//  warikan_app
//
//  Created by kawaharadai on 2017/07/22.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var totalfee_text: UITextField!
    @IBOutlet weak var totalfee_label: UILabel!
    @IBOutlet weak var totalfee_unit: UILabel!
    @IBOutlet weak var people_text: UITextField!
    @IBOutlet weak var people_label: UILabel!
    @IBOutlet weak var people_unit: UILabel!
    @IBOutlet weak var result_label: UILabel!
    @IBOutlet weak var resutl_title: UILabel!
    @IBOutlet weak var count_view: UIView!
    @IBOutlet weak var reset_view: UIView!
    @IBOutlet weak var warikan_button: UIButton!
    @IBOutlet weak var reset_button: UIButton!
    
    //合計金額を数値型のまま保存しておく変数
    var count_box:Int = 0
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        addLayer()
        settingFont()
    }
    
    // MARK: - Setup Methods
    private func setup() {
        totalfee_text.delegate = self
        people_text.delegate = self
        
        totalfee_text.placeholder = "未入力"
        people_text.placeholder = "未入力"

        /// キーボード上部に「完了」ボタンを追加する
        addKey()
    }

    /// 割り勘ボタンとリセットボタンのviewを丸める
    private func addLayer() {
        Deform.corner(view: self.count_view,
                      radius: self.count_view.frame.width / 2)
        Deform.corner(view: self.reset_view,
                      radius: self.reset_view.frame.width / 2)
        Deform.corner(view: self.result_label,
                      radius: 5)
    }
    
    /// 画面サイズに応じてフォントサイズを変更
    private func settingFont() {
        totalfee_label.font = UIFont.systemFont(ofSize: UIFont.main_text)
        totalfee_text.font = UIFont.systemFont(ofSize: UIFont.text_field)
        totalfee_unit.font = UIFont.systemFont(ofSize: UIFont.main_text)
        people_label.font = UIFont.systemFont(ofSize: UIFont.main_text)
        people_text.font = UIFont.systemFont(ofSize: UIFont.text_field)
        people_unit.font = UIFont.systemFont(ofSize: UIFont.main_text)
        resutl_title.font = UIFont.systemFont(ofSize: UIFont.main_text2)
        result_label.font = UIFont.boldSystemFont(ofSize: UIFont.long_text)
        warikan_button.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.main_text)
        reset_button.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.main_text)
    }
    
    // MARK: - Private Methods
    /// 割り勘代金の計算（割り切れない場合は100円単位で切り上げ）
    private func warikan_action(totalfee: String?, people: String?) {
        
        /// 入力情報のチェック（未入力ならアラートを出して処理中断）
        guard
            let totalFee = totalfee,
            let inputPeople = people,
            check(check_fee: totalFee, check_people: inputPeople) else {
            return
        }
        
        //キーボードのテキストをInt型に変換
        let place1 = count_box
        guard let place2 = Int(inputPeople) else {
            print("人数を数値型に変換することに失敗")
            return
        }
        
        //totalfee/peopleの結果を出力
        var place3 = Double(place1/place2)
        
        //place3が割り切れなかった場合は、切り上げ処理
        if place1 % place2 != 0 {
            //切り上げ処理
            place3 = Calculation.round_up(value: place3)
        }
        
        //３桁ごとにカンマを入れる
        let warikan_place = Calculation.add_comma(value: place3)
        
        //計算結果をラベルに出力
        result_label.text = "1人辺りの支払い額は、\(warikan_place)円です。"
    }
    
    /// 未入力、入力人数のチェック
    func check(check_fee: String, check_people: String) -> Bool {
        
        guard !check_fee.isEmpty || !check_people.isEmpty else {
            showAlert(title: nil, message: "合計金額又は、人数が未入力です。")
            return false
        }
        
        guard !check_people.isEmpty, let box = Int(check_people), box > 0 else {
            showAlert(title: nil, message: "人数は2名以上入力してください。")
            return false
        }
        
        return true
    }
    
    private func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    //キーボード上部に「完了」ボタンを追加（キーボード設定によりreturnキーがなくなっているため）
    private func addKey() {
        
        //デフォルトカラーを作成（ボタンの文字色用）
        let default_color1 = #colorLiteral(red: 0.07450980392, green: 0.5647058824, blue: 1, alpha: 1)
        let default_color2 = #colorLiteral(red: 0.07450980392, green: 0.5647058824, blue: 1, alpha: 0.3)
        
        // デバイスごとのスクリーン幅と高さを取得
        let screen_width = UIScreen.main.bounds.width
        let screen_height = UIScreen.main.bounds.height
        // ボタンを追加するためのViewを生成
        let onKeyboard = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screen_width,
                                              height: screen_height / 14))
        // viewの色を指定
        onKeyboard.backgroundColor = UIColor.white
        
        // 完了ボタンの生成
        let btn = UIButton(frame: CGRect(x: screen_width-screen_width / 4,
                                         y: 0,
                                         width: screen_width / 4,
                                         height: screen_height / 14))
        //ボタンの背景を設定
        btn.backgroundColor = UIColor.white
        //ボタンのtitleを設定
        btn.setTitle("完了", for: .normal)
        //ボタンのフォントを設定
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.main_text)
        //titleを中央寄せ
        btn.contentHorizontalAlignment = .center
        //押したときの色と押してない時の色を設定
        btn.setTitleColor(default_color1, for: .normal)
        btn.setTitleColor(default_color2, for: .highlighted)
        //ボタンをおした時の実行メソッドを設定
        btn.addTarget(self,
                      action: #selector(MainViewController.close_keyboard),
                      for: .touchUpInside)
        // viewへ完了ボタンを追加
        onKeyboard.addSubview(btn)
        //テキストフィールドにキーボード用のviewを追加
        totalfee_text.inputAccessoryView = onKeyboard
        people_text.inputAccessoryView = onKeyboard
    }
    
    //キーボードを下げる
    func close_keyboard(){
        self.view.endEditing(true)
    }
    
    // MARK: - Action Methods

    /// キーボード以外のスクリーン部分をタッチした時にキーボードを下げる
    @IBAction func screen_touch(_ sender: Any) {
        close_keyboard()
    }
    
    /// 割り勘ボタンを押した時のアクション
    @IBAction func warikan_start(_ sender: Any) {
        warikan_action(totalfee: totalfee_text.text,
                       people: people_text.text)
    }
    
    //リセットボタンを押した時のアクション
    @IBAction func clear(_ sender: Any) {
        totalfee_text.text = ""
        people_text.text = ""
        result_label.text = "なし"
        count_box = 0
        
    }
}

// MARK: - UITextFieldDelegate Methods
extension MainViewController: UITextFieldDelegate {
    //テキストフィールドに入力された文字列をチェックし、半角英数字でなければ入力を無効にする
    //(キーボードは半角英数字で制限しているため、コピペ入力への対策)
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return string.isEmpty || string.range(of:"^[0-9]+$",
                                              options: .regularExpression,
                                              range: nil, locale: nil) != nil
    }
    
    //合計金額テキストフィールドの入力が完了した時に、3桁ごとにカンマを入れる
    func textFieldDidEndEditing(_ textField: UITextField) {
        //合計金額に入力された値のみ、計算用に値を変数に入れておく
        if textField.tag == 1 {
            guard
                let inputText = textField.text,
                !inputText.isEmpty,
                let inputNumber = Int(inputText) else {
                return
            }
            count_box = inputNumber
            //カンマ追加処理（桁数のチェックはするのか、4桁以上など）
            if let count_box2:Double = Double(inputText) {
                textField.text = Calculation.add_comma(value: count_box2)
            }
        }
    }
}
