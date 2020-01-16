//
//  Movie+Network.swift
//  Movies
//
//  Created by Lucas Santana Brito on 16/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import Foundation
import Alamofire

extension Movie {
    
    static func downloadMovies(page: Int, completed: @escaping (Bool, [Movie], Int) -> Void) {
        
        let urlRquest = "\(urlBaseMovies)?api_key=\(apiKey)&language=\(language)&page=\(page)"
    
        Alamofire.request(urlRquest, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
            
            var status = false
                
            switch response.result {
            case .success(let value):
                
                guard let data = value as? [String: Any] else { return }
                
                do {
                    let totalPages = data["total_pages"] as? Int ?? 1
            
                    let jsonData = try JSONSerialization.data(withJSONObject: data["results"] as Any, options: [])
                    let movies = try JSONDecoder().decode([Movie].self, from: jsonData)
                    status = true
                    completed(status, movies, totalPages)
                    
                } catch let error {
                    debugPrint("1 -> \(error)")
                    completed(status, [Movie](), 0)
                }
                
            case .failure(let error):
                debugPrint("2 -> \(error)")
                completed(status, [Movie](), 0)
            }
        }
    }
}
