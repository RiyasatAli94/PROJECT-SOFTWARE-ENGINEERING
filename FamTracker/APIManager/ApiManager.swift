//
//  ApiManager.swift
//  Orbis
//
//  Created by Riyasat on 09/08/20.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation
import Alamofire
import MessageUI


let Api = ApiManager.shared

class ApiManager {
    static let shared = ApiManager()
    fileprivate let basePath = "https://lightning-yoga-api.herokuapp.com/yoga_poses"
    fileprivate init() {
        session = Session()
    }
    
    // APi Commmon method which is call
    var session : Session
    
    typealias ApiCompletionHandler = ((Int, Bool, Data?) -> Bool)  // statuscode, success, json -> bool whether ApiManager should continue to show error message
    
    fileprivate func request(url : String, shouldAddUserID: Bool = true, method : HTTPMethod, parameters : [String: Any]? = nil, shouldShowActivity: Bool = true, useJsonEncoding: Bool = false, completion: ApiCompletionHandler? = nil) {
        let parameters : [String : Any] = (parameters == nil) ? [String : Any]() : parameters!
        
        var urlEncoding : ParameterEncoding = URLEncoding.default
        
        var headers:HTTPHeaders = HTTPHeaders()
        if useJsonEncoding {
            urlEncoding = JSONEncoding.default
            headers.add(HTTPHeader(name: "Content-Type", value: "text/html"))
        }
        
        
        
        let dataRequest : DataRequest = self.session.request(url, method: method, parameters: parameters, encoding: urlEncoding, headers: headers)
        
        
        dataRequest.response { response in
            let handleCompletion = true
            var json : [String: AnyObject]? = nil
            
            if let data = response.data {
                do {
                    json = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject]
                    if let json = json{
                        print(json)
                    }
                } catch {
                    
                }
            }
            
            let error = response.error as NSError?
            let status = response.response?.statusCode ?? 600
            
            var errorMessage : (title: String, message: String)? = nil
            if let error = error {
                
                
                
                if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                    errorMessage = (title: "No Internet Connection", message: "Your internet connection appears to be offline")
                } else {
                    errorMessage = (title: "Network Error", message: "There was an unexpected error with your request.")
                }
            } else if status >= 600 {
                
                errorMessage = (title: "Network Error", message: "There was an unexpected error with your request.")
            } else if status >= 500 {
                
                let message = json?["status"] as? String ?? "There was an unexpected server failure. Please try again later"
                
                errorMessage = (title: "Unexpected Error", message: message)
                
            } else if status >= 400 {
                
                
                let message = json?["message"] as? String ?? "The supplied information was invalid.  Please double check and re-submit your request"
                errorMessage = (title: "Error", message: message)
                
                if status == 404 {
                    
                } else if status == 410 {
                    
                }
                
            } else if status >= 300 {
                let message = json?["message"] as? String ?? "Request redirection error.  Please try again"
                errorMessage = (title: "Error", message: message)
            }
            
            var shouldShowErrorAlert = true
            let success = (errorMessage == nil)
            if handleCompletion && completion != nil {
                let jsonData = response.data
                shouldShowErrorAlert = completion!(status, success, jsonData) && shouldShowErrorAlert
            }
        }
    }
    
    
    
    func getAPIData(completion: ApiCompletionHandler? = nil)
    {
        let url = basePath
        let parameters = ["": ""] as [String : Any]
        self.request(url: url, method: .get,parameters: parameters, completion: completion)
    }
    
    func getImage(imgUrl : String, completion: ApiCompletionHandler? = nil)
    {
        let url = imgUrl
        let parameters = ["": ""] as [String : Any]
        self.request(url: url, method: .get,parameters: parameters, completion: completion)
    }
}
