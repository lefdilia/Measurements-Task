//
//  NetworkManager.swift
//  TestTask
//
//  Created by Lefdili Alaoui Ayoub on 12/4/2022.
//

import Foundation


protocol DataPresentable: AnyObject {
    func presentData(data: [MeasurementModel])
}

class NetworkManager: NSObject, URLSessionDataDelegate {
    
    private var session: URLSession! = nil
    
    weak var delegate: DataPresentable?
    
    override init() {
        super.init()
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringCacheData
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: .main)
    }
    
    func startRequest(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = self.session.dataTask(with: request)
        task.resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        let pattern = "^data\\:(\\s+)?|\\\n+"
        let cleanData = String(data: data, encoding: .utf8)?.replacingOccurrences(of: pattern, with: "", options: .regularExpression, range: nil).trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let cleanData = cleanData?.data(using: .utf8) else {
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedResult = try decoder.decode([MeasurementModel].self, from: cleanData)
            let data = decodedResult.filter({ $0.measurements.first?.isEmpty == false })
            delegate?.presentData(data: data)
            
        } catch {}
    }
}

/*
 "name": "PM1",
 "unit": "mg/mÂ³",
 "measurements": [[1649731372, 0.3495395752980656]],
 "_id": "6254d0163dc0de0001c65007"
 */
