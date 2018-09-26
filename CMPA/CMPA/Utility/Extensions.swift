//
//  Extensions.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 20/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation
import UIKit

protocol AppClientDelegate {
    var appClient: AppClient { get }
}

extension AppClientDelegate {
    var appClient: AppClient {
        return (UIApplication.shared.delegate as! AppDelegate).appClient
    }
}

extension UIImageView: AppClientDelegate {
    func downloadImage(from urlString: String?, id: Int?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = nil
            return
        }
        
        if let id = id, let data = appClient.imageCache[id], let image = UIImage(data: data) {
            self.image = image
            return
        }
        
        let request = URLRequest(url: url)
        let storedId = id
        
        let task = appClient.get(request: request) {(data, response, error) in
            guard let data = data, let image = UIImage(data: data), id == storedId else {
                self.image = nil
                return
            }
            
            DispatchQueue.main.async {
                if let id = storedId {
                    self.appClient.imageCache[id] = data
                }
                self.image = image
            }
        }
        
        task.resume()
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
