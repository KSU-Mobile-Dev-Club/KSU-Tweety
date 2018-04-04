//
//  KSUTweetClient.swift
//  KSU MDC
//
//  Created by Reagan Wood on 12/18/17.
//  Copyright © 2017 RW Apps. All rights reserved.
//

import Foundation

class KSUTweetClient: NSObject {
    
    var session = URLSession.shared
    
    // get method for gettting info from EmailVerification server
    func taskForGETMethod (path: String, methodParameters: [String:AnyObject], taskForGetHandler: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionTask {
        
        // create the url
        let url = twitterAPIURLFromParameters(path: path, parameters: methodParameters)
        
        // create request
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer AAAAAAAAAAAAAAAAAAAAACJl4wAAAAAAHpkA5UaHDodjo01kteq9nB%2Fqjns%3DGxarAYeiInh2pTDK3WvhRwsmrPCVVchsT48sj6CcyUsfPdglvP", forHTTPHeaderField: "Authorization")
        print(urlRequest)
        // create a session to parse the data
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            func sendError(error: String, statusCode: Int?) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                if let statusCode = statusCode {
                    taskForGetHandler(nil, NSError(domain: "taskForGetMethod", code: statusCode, userInfo: userInfo))
                } else {
                    taskForGetHandler(nil, NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
                }
            }
            
            // check for error
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(String(describing: error))", statusCode: 1)
                return
            }
            
            // check for successful status code
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (statusCode >= 200 && statusCode <= 299) else {
                sendError(error: "Your request returned a status code other than 2xx!", statusCode: (response as? HTTPURLResponse)?.statusCode)
                return
            }
            
            // set the data
            guard let data = data else {
                sendError(error: "No data was returned by the request!", statusCode: 200)
                return
            }
            
            self.parseJSONData(data: data, completionHandler: taskForGetHandler)
            
        } // end task
        
        task.resume()
        
        return task
    }
    
    private func twitterAPIURLFromParameters(path: String, parameters: [String:AnyObject]) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.ApiScheme
        components.host = Constants.ApiHost
        components.path = path
        components.queryItems = [URLQueryItem]() as [URLQueryItem]?
        
        print(components.queryItems)
        print(components.url)
        print(components.host!)
        print(components.path)
        print(components.scheme!)
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem as URLQueryItem)
        }
        
        return components.url!
    }
    
    func taskForPostMethodSingleJSONKey (method: String, jsonBody: [String?], completionHandlerForPost: @escaping (_ data: AnyObject?, _ error: NSError?) -> Void) -> URLSessionTask {
        
        // create the url
        let urlForPost = Constants.CoreTwitterAPIURL + method
        let url = URL(string: urlForPost)!
        print(url)
        // create a mutable request
        var request = URLRequest(url: url)
        // create method and values for the request
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted)
        }
        catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not serialize the jsonBody data"]
            completionHandlerForPost(nil, NSError(domain: "parseJSONData", code: 1, userInfo: userInfo))
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            // function for displaying error message
            func sendError(error: String, statusCode: Int?) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                if let statusCode = statusCode {
                    completionHandlerForPost(nil, NSError(domain: "taskForGetMethod", code: statusCode, userInfo: userInfo))
                } else {
                    completionHandlerForPost(nil, NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
                }
            }
            
            // check for error
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(String(describing: error))", statusCode: 1)
                return
            }
            
            // check for successful response status code
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print((response as? HTTPURLResponse)?.statusCode)
                sendError(error: "Your request returned a status code other than 2xx!", statusCode: (response as? HTTPURLResponse)?.statusCode)
                return
            }
            
            // check for good data
            guard let data = data else {
                sendError(error: "No data was returned by the request!", statusCode: 200)
                return
            }
            
            // parse the data
            self.parseJSONData(data: data, completionHandler: completionHandlerForPost)
        }
        
        // resume the task
        task.resume()
        
        // return the closure with data
        return task
    }
    
    func taskForPostMethod (method: String, jsonBody: [String:AnyObject?], completionHandlerForPost: @escaping (_ data: AnyObject?, _ error: NSError?) -> Void) -> URLSessionTask {
        
        // create the url
        let urlForPost = Constants.CoreTwitterAPIURL + method
        let url = URL(string: urlForPost)!
        print(url)
        print (jsonBody)
        // create a mutable request
        var request = URLRequest(url: url)
        // create method and values for the request
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted)
        }
        catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not serialize the jsonBody data"]
            completionHandlerForPost(nil, NSError(domain: "parseJSONData", code: 1, userInfo: userInfo))
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            // function for displaying error message
            func sendError(error: String, statusCode: Int?) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                if let statusCode = statusCode {
                    completionHandlerForPost(nil, NSError(domain: "taskForGetMethod", code: statusCode, userInfo: userInfo))
                } else {
                    completionHandlerForPost(nil, NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
                }
            }
            
            // check for error
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(String(describing: error))", statusCode: 1)
                return
            }
            
            // check for successful response status code
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print((response as? HTTPURLResponse)?.statusCode)
                sendError(error: "Your request returned a status code other than 2xx!", statusCode: (response as? HTTPURLResponse)?.statusCode)
                return
            }
            
            // check for good data
            guard let data = data else {
                sendError(error: "No data was returned by the request!", statusCode: 200)
                return
            }
            
            // parse the data
            self.parseJSONData(data: data, completionHandler: completionHandlerForPost)
        }
        
        // resume the task
        task.resume()
        
        // return the closure with data
        return task
    }
    
    func taskForPutMethod (method: String, jsonBody: [String:AnyObject?], completionHandlerForPut: @escaping (_ data: AnyObject?, _ error: NSError?) -> Void) -> URLSessionTask {
        
        // create the url
        let urlForPost = Constants.CoreTwitterAPIURL + method
        let url = URL(string: urlForPost)!
        print(url)
        print(jsonBody)
        // create a mutable request
        var request = URLRequest(url: url)
        // create method and values for the request
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted)
        }
        catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not serialize the jsonBody data"]
            completionHandlerForPut(nil, NSError(domain: "parseJSONData", code: 1, userInfo: userInfo))
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            // function for displaying error message
            func sendError(error: String, statusCode: Int?) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                if let statusCode = statusCode {
                    completionHandlerForPut(nil, NSError(domain: "taskForGetMethod", code: statusCode, userInfo: userInfo))
                } else {
                    completionHandlerForPut(nil, NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
                }
            }
            
            // check for error
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(String(describing: error))", statusCode: 1)
                return
            }
            
            // check for successful response status code
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print((response as? HTTPURLResponse)?.statusCode)
                sendError(error: "Your request returned a status code other than 2xx!", statusCode: (response as? HTTPURLResponse)?.statusCode)
                return
            }
            
            // check for good data
            guard let data = data else {
                sendError(error: "No data was returned by the request!", statusCode: 200)
                return
            }
            
            // parse the data
            self.parseJSONData(data: data, completionHandler: completionHandlerForPut)
        }
        
        // resume the task
        task.resume()
        
        // return the closure with data
        return task
    }
    
    // function parses JSON data
    func parseJSONData (data: Data, completionHandler: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        // Parse the JSON data and return through the completion handler
        var parsedResult: AnyObject!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            completionHandler(parsedResult, nil)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandler(nil, NSError(domain: "parseJSONData", code: 1, userInfo: userInfo))
        }
    }
}

func KSUTweetyAPISharedInstance() -> KSUTweetClient {
    struct Singleton {
        static var sharedInstance = KSUTweetClient()
    }
    return Singleton.sharedInstance
}

