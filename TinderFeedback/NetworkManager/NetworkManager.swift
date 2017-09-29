//
//  NetworkManager.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 29/09/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import Foundation

class NetworkManager {

    static let basicUrl = "https://a4fa1f62.ngrok.io/"
    static let loginUrl = "login"
    static let clues = "clues"

    class func login(login: String, password: String) -> Promise<ClueModel> {
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
}
