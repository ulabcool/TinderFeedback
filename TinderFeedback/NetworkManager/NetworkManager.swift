//
//  NetworkManager.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 29/09/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import Foundation

class NetworkManager {

    let basicUrl = "https://452dd126.ngrok.io/"
    let loginUrl = "login"
    let cluesPath = "clues"

    func login(login: String, password: String) -> Promise<ClueModel> {
        let loginData = String(format: "%@:%@", login, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()

        
        // create the request
        let url = URL(string: "\(basicUrl)\(loginUrl)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")

        //making the request
        return Promise { fulfill, reject in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("\(error)")
                    return
                }

                if let httpStatus = response as? HTTPURLResponse {
                    // check status code returned by the http server
                    switch httpStatus.statusCode {
                    case 200...204:
                        print("response :\n\(httpStatus.description)")
                        print("status code = \(httpStatus.statusCode)")
                        UserDefaults.standard.set(base64LoginData, forKey: "userBase64") //Bool
                        fulfill(ClueModel(clueId: "idd", rating: 6, text: "hhhhhhh", date: "daate"))
                    case 400...404:
                        reject(NSError(domain: "error", code: 100, userInfo: nil))
                    default:
                        reject(NSError(domain: "error", code: 100, userInfo: nil))
                    }
                    // process result
                }
            }
            task.resume()
        }
    }
    
    func getClues() -> Promise<[ClueModel]> {
        guard let base64 = UserDefaults.standard.string(forKey: "userBase64") else {
            return Promise {_,reject in
                reject(NSError(domain: "not logged in", code: 123, userInfo: nil))
            }
        }

        
        // create the request
        let url = URL(string: "\(basicUrl)\(cluesPath)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        
        //making the request
        return Promise { fulfill, reject in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse {
                    // check status code returned by the http server
                    switch httpStatus.statusCode {
                    case 200...204:
                        print("response :\n\(httpStatus.description)")
                        print("status code = \(httpStatus.statusCode)")
                        
                        /////JOSN 
                        do {
                            let parsedData = try JSONSerialization.jsonObject(with: data) as! [Any]
                            print(parsedData)
                            var cluesArray = [ClueModel]()
                            for rawClue in parsedData {
                                let clue = ClueModel(json: rawClue as! [String : Any])
                                cluesArray.append(clue)
                            }
                            
                            fulfill(cluesArray)
                            
                        } catch let error as NSError {
                            print(error)
                        }
                    case 400...404:
                        reject(NSError(domain: "error", code: 100, userInfo: nil))
                    default:
                        reject(NSError(domain: "error", code: 100, userInfo: nil))
                    }
                    // process result
                }
            }
            task.resume()
        }
    }
    
    func submitAction(action: String, clue: ClueModel) -> Promise<Bool> {
        guard let base64 = UserDefaults.standard.string(forKey: "userBase64") else {
            return Promise {_,reject in
                reject(NSError(domain: "not logged in", code: 123, userInfo: nil))
            }
        }
        
        // create the request
        let url = URL(string: "\(basicUrl)\(cluesPath)/\(clue.clueId)/\(action)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        
        //making the request
        return Promise { fulfill, reject in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse {
                    // check status code returned by the http server
                    switch httpStatus.statusCode {
                    case 200...204:
                        print("response :\n\(httpStatus.description)")
                        print("status code = \(httpStatus.statusCode)")

                        fulfill(true)
                    case 400...404:
                        reject(NSError(domain: "error", code: 100, userInfo: nil))
                    default:
                        reject(NSError(domain: "error", code: 100, userInfo: nil))
                    }
                    // process result
                }
            }
            task.resume()
        }
    }
}
