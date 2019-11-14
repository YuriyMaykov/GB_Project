//
//  VKLoginController.swift
//  Vk_Maykov
//
//  Created by Юрий on 25/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class VKLoginController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    override func loadView() {
        super.loadView()
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var urlCmps = URLComponents()
        urlCmps.scheme = "https"
        urlCmps.host = "oauth.vk.com"
        urlCmps.path = "/authorize"
        urlCmps.queryItems = [
            URLQueryItem(name: "client_id", value: "7183641"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]

        webView.load(URLRequest(url: urlCmps.url!))
        webView.navigationDelegate = self

        /*
        let url = URL(string: "https://oauth.vk.com/authorize?client_id=7183641&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=groups&response_type=token")
        let request = URLRequest(url: url!)
        webView.load(request)
        */
    }
}

extension VKLoginController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        let session = Session.shared
        session.token = params["access_token"] ?? ""
        session.userId = params["user_id"] ?? ""
        session.expiresIn = params["expires_in"] ?? ""
        
        decisionHandler(.cancel)
        
        if (session.token != "" && session.userId != "" && session.expiresIn != "") {
            performSegue(withIdentifier: "fromVKLoginController", sender: self)
            
        }
 

    }
}

