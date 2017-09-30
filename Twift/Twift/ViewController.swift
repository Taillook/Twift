//
//  ViewController.swift
//  Twift
//
//  Created by Taillook on 2017/09/25.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import UIKit
import Alamofire
import OAuthSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let api_key = "W2tOU5CYeOnACCEcYfZvv9jbq"// APIキー
        let api_secret = "cMZOWZzuo0E1oHzYUjyofmmj1CVP6DKYkm0D9eBmzDOrQCeSpn"// APIシークレット
        let access_token = "4915971073-INK5QZuYRfYXasxxqLr46m5V2lXqbOGquT7olwb"// アクセストークン
        let access_token_secret = "8AZfCBFMNumRm0PlDHJEZ3aUczD0JHVIpp1PfIx8ptD5p"// アクセストークンシークレット
        var request_url = "https://api.twitter.com/1.1/statuses/home_timeline.json"// エンドポイント
        let request_method = "GET"
        
        let params_a: [String: String] = [:]
        
        let signature_key = api_secret.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!+"&"+access_token_secret.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        print(signature_key)
        
        let params_b = [
            "oauth_token": access_token,
            "oauth_consumer_key": api_key,
            "oauth_signature_method": "HMAC-SHA1",
            "oauth_timestamp": String(Int(Date().timeIntervalSince1970)),
            "oauth_nonce": String(format: "%04d", Int(arc4random()%1000)),
            "oauth_version": "1.0"
        ]
        
        var params_c = params_a.union(params_b).sorted(by: { $0.0 < $1.0 })
        
        var request_params = ""
        for (i,e) in params_c.enumerated() {
            request_params += e.key + "=" + e.value
            if i != params_c.count - 1 {
                request_params += "&"
            }
        }
        
        request_params = request_params.replacingOccurrences(of: "+", with: "%7E")
        request_params = request_params.replacingOccurrences(of: "%20", with: "~")
        request_params = request_params.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        let encoded_request_method = request_method.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let encoded_request_url = request_url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        let signature_data = encoded_request_method + "" + encoded_request_url + "&" + request_params
        
        let signature = signature_data.hmac(algorithm: HMACAlgorithm.SHA1, key: signature_key)
        params_c.append(("oauth_signature", signature))
        
        var header_params = ""
        for (i,e) in params_c.enumerated() {
            header_params += e.key + "=" + e.value
            if i != params_c.count - 1 {
                header_params += ","
            }
        }
        
        if params_a.count > 0 {
            var params_a_query = ""
            for (i,e) in params_a.enumerated() {
                params_a_query += e.key + "=" + e.value
                if i != params_a.count - 1 {
                    params_a_query += "&"
                }
            }
            request_url += "?" + params_a_query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        }
        
        /*headers["authorization"] = "OAuth oauth_consumer_key="+"70z7Vyvx0IIRoOuyRNn3VaqBt"+",oauth_token="+"PQpmwiWKm5BZBw7JYbyJRtUydYurCds9y1Zug2FtBu1nW"+",oauth_signature_method=HMAC-SHA1,oauth_timestamp="+String(Int(Date().timeIntervalSince1970))+",oauth_nonce="+String(format: "%04d", Int(arc4random()%1000))+",oauth_version=1.0,oauth_signature=aaa"
        */
        print(header_params)
        print(request_url)
        Alamofire.request(request_url, headers: ["authorization": "OAuth " + header_params]).responseJSON{ response in
            print(response.value!)
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
