//
//  ViewController.swift
//  Demo(tax_calculate)
//
//  Created by Sin on 2023/1/27.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    //TaxRefound的Outlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var taxRefoundResult: UILabel!
    @IBOutlet weak var expendResult: UILabel!
    @IBOutlet weak var finalPriceTextField: UITextField!
    @IBOutlet weak var taxTextField: UITextField!
    @IBOutlet weak var handlingFeeTextField: UITextField!
    //SalesTax的Outlet
    @IBOutlet weak var salesTaxResult: UILabel!
    @IBOutlet weak var finalPriceResult: UILabel!
    @IBOutlet weak var listPriceTextField: UITextField!
    @IBOutlet weak var salesTaxTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        //輸入框初始化
        finalPriceTextField.delegate = self
        taxTextField.delegate = self
        handlingFeeTextField.delegate = self
        listPriceTextField.delegate = self
        salesTaxTextField.delegate = self
    }
    //鍵盤設定

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if scrollView.contentOffset.x == 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: 336), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x: 414, y: 336), animated: true)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if scrollView.contentOffset.x == 0{
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x: 414, y: 0), animated: true)
        }
        
    }
    @objc func keyboardShown(notification: Notification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        //取得鍵盤尺寸
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        print(keyboardSize.height)
    }
    
    //TaxRefound的Action
    @IBAction func calculateButton(_ sender: Any) {
        //點擊「計算」按鈕時收鍵盤
        view.endEditing(true)
        //先讀出使用者輸入的字串。後面的Text型別為String?，表示要用!讀取。
        //由於TextField如果沒有輸入東西會視為空字串，所以不會有nil的情況，就不需用ifelse去排除nil狀況。
        let finalPriceText = finalPriceTextField.text!
        let taxText = taxTextField.text!
        let handlingFeeText = handlingFeeTextField.text!
        //再將讀取optional的字串轉為Double型別
        //會發現設定的常數型別為「Double?」，代表要用!讀取，但是當使用者輸入的字串出現無法判別的內容（ex.abc），就會有nil的情況，程式就會死掉，所以要用ifelse做排除，不能在Double後面直接加!
        let finalPrice = Double(finalPriceText)
        let tax = Double(taxText)
        let handlingFee = Double(handlingFeeText)
        //設定條件：當三個常數都不是nil時，才會執行計算程式
        //因為上面轉換Double型別沒有加!，所以在{}內時要記得加!，不然會讀不到東西
        if finalPrice != nil, tax != nil, handlingFee != nil {
            let taxRefound = (tax! + handlingFee!)/100 * finalPrice!
            let expend = finalPrice! - taxRefound
            taxRefoundResult.text = String(format:"%.0f", taxRefound)
            expendResult.text = String(format:"%.0f", expend)
        }
        
    }
    @IBAction func reset(_ sender: Any) {
        taxRefoundResult.text = "0"
        expendResult.text = "0"
        finalPriceTextField.text = ""
        taxTextField.text = ""
        handlingFeeTextField.text = ""
        if scrollView.contentOffset.y == 0{
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x: 0, y: 336), animated: true)
        }
    }
    
    //SalesTax的Action
    @IBAction func salesTaxCalculatorButton(_ sender: Any) {
       
        //點擊「計算」按鈕時收鍵盤
        view.endEditing(true)
        //先讀出使用者輸入的字串。後面的Text型別為String?，表示要用!讀取。
        //由於TextField如果沒有輸入東西會視為空字串，所以不會有nil的情況，就不需用ifelse去排除nil狀況。
        let listPriceText = listPriceTextField.text!
        let salesTaxText = salesTaxTextField.text!
        //再將讀取optional的字串轉為Double型別
        //會發現設定的常數型別為「Double?」，代表要用!讀取，但是當使用者輸入的字串出現無法判別的內容（ex.abc），就會有nil的情況，程式就會死掉，所以要用ifelse做排除，不能在Double後面直接加!
        let listPrice = Double(listPriceText)
        let salesTax = Double(salesTaxText)
        //設定條件：當兩個常數都不是nil時，才會執行計算程式
        //因為上面轉換Double型別沒有加!，所以在{}內時要記得加!，不然會讀不到東西
        if listPrice != nil, salesTax != nil {
            let salesTaxLabel = listPrice! * (salesTax!/100)
            let finalPriceLabel = listPrice! + salesTaxLabel
            salesTaxResult.text = String(format:"%.0f", salesTaxLabel)
            finalPriceResult.text = String(format:"%.0f", finalPriceLabel)
        }
        
        func SalesTaxResetButton(_ sender: Any) {
            salesTaxResult.text = "0"
            finalPriceResult.text = "0"
            listPriceTextField.text = ""
            salesTaxTextField.text = ""
            if scrollView.contentOffset.y == 0{
                scrollView.setContentOffset(CGPoint(x:  414, y: 0), animated: true)
            } else {
                scrollView.setContentOffset(CGPoint(x: 414, y: 336), animated: true)
            }
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: 414, y: 0), animated: true)
    }
    @IBAction func previousPage(_ sender: Any) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
