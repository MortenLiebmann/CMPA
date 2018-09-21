//
//  Networking.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 21/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation
import SystemConfiguration

public class Networking {
    class func isConnectedToNetwork() -> Bool {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(reachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
    }
}
