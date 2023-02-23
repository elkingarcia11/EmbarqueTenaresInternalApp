//
//  WebService.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/22/23.
//

import Foundation

enum AuthenticationError : Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginRequestBody : Codable {
    let username: String
    let password: String
}

struct LoginResponse : Codable {
    let access_token : String?
    let token_type : String?
}

class WebService {
    
    
    
    func login(username: String, password: String, completion: @escaping (Result<String,AuthenticationError>) -> Void){
        
        guard let url = URL(string: "http://server.embarquetenares.com:8000/api/tracker/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = "username=\(username)&password=\(password)".data(using: .utf8)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.access_token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
        }.resume()
        
    }
    
    func getAllTransactions(token : String, completion: @escaping (Result<String,AuthenticationError>) -> Void){
        guard let url = URL(string: "http://server.embarquetenares.com:8000/api/tracker/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
    }
    
}
