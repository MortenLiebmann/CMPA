//
//  Extensions.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 20/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = nil
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                self.image = nil
                return
                
            }
            
            DispatchQueue.main.async {
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
