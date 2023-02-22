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
    let accessToken : String?
    let tokenType : String?
}

class WebService {
    
    func login(username: String, password: String, completion: @escaping (Result<String,AuthenticationError>) -> Void){
        
        guard let url = URL(string: "http://server.embarquetenares.com:8000/api/tracker/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request){
            (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                    completion(.failure(.custom(errorMessage: "Invalid credentials")))
                    return
            }
            
            guard let token = loginResponse.accessToken else {
                completion(.failure(.custom(errorMessage: "Invalid credentials")))
                return
            }
            completion(.success(token))
            
        }.resume()
        
    }
}
