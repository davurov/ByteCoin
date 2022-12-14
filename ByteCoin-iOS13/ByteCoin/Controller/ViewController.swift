//
//  ViewController.swift
//  ByteCoin
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {

    
    
    var coinManager = CoinManager()
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencyLbl.text = coinManager.currencyArray[row]
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }

    @IBOutlet weak var bitCoinLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
    }
    

}

extension ViewController: CoinManagerDelgate {
    
    func didUpdateData(weather: CoinModul) {
        DispatchQueue.main.async {
            self.bitCoinLbl.text = String(weather.price)
            self.currencyLbl.text = weather.coinName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    

}
