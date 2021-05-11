//
//  ServiceManager.swift
//  Shop
//
//  Created by Harpreet on 10/05/21.
//

import UIKit




class ServiceManager {
    
    static let shared = ServiceManager()
        
    func getDataFromServer(_ url: URL, completion: @escaping (Result<CategoryListModel,Error>) -> ()) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            if let safeData = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(CategoryListModel.self, from: safeData)
                    completion(.success(decodedData))
                } catch let error{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
