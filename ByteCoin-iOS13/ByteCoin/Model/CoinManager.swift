//
//  CoinManager.swift
//  ByteCoin
//

import Foundation
protocol CoinManagerDelgate {
    func didUpdateData(weather: CoinModul)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "CBB743E8-3FE8-4FD2-A79B-EF92CA9DEE7E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performeRequest(urlString: url)
    }
    
    var delegate: CoinManagerDelgate?
    
    func performeRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather =  parseJSON(weatherData: safeData) {
                        delegate?.didUpdateData(weather: weather)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(weatherData: Data) -> CoinModul? {
        let decoder = JSONDecoder()
        do {
           let decodedData =  try decoder.decode(CoinData.self, from: weatherData)
            let name = decodedData.asset_id_base
            let currencyName = decodedData.asset_id_quote
            let coinPrice = decodedData.rate
            let coin = CoinModul(price: coinPrice, currencyName: currencyName, coinName: name)
            return coin
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }


}
