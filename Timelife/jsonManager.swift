//
//  jsonManager.swift
//  Timelife
//
//  Created by Giulia Zandonà on 21/05/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import Foundation
import Alamofire

class jsonManager: UIViewController {

    
    
public var manager: Alamofire.SessionManager =
{
    
    // Create the server trust policies
    let serverTrustPolicies: [String: ServerTrustPolicy] = [
        "timelifeweb.test": .disableEvaluation
    ]
    
    // Create custom manager
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    let manager = Alamofire.SessionManager(
        configuration: URLSessionConfiguration.default,
        serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
    )
    
    return manager
    }()
}

