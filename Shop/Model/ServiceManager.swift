//
//  ServiceManager.swift
//  Shop
//
//  Created by macexpert on 10/05/21.
//

import UIKit

class ServiceManager {
    
    private var activityView: UIActivityIndicatorView?

    func getDataFromServer<T:Decodable>(_ urlString: String, completion: @escaping (T) -> ()) {
        if let url = URL(string: urlString) {
            showActivityIndicator()
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {[weak self] (data, response, error) in
                if error != nil {
                    self?.hideActivityIndicator()
                    self?.showErrorAlert()
                    return
                }
                if let safeData = data {
                    self?.hideActivityIndicator()
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(T.self, from: safeData)
                        completion(decodedData)
                    } catch {
                        self?.showErrorAlert()
                    }
                }
            }
            task.resume()
        } else {
            self.hideActivityIndicator()
            showErrorAlert()
        }
    }
    
    private func showErrorAlert() {
        DispatchQueue.main.async {
            Alert.showAlert(message: Errors.serverError)
        }
    }

    // MARK:-  Activity Indicator
    private func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = .black
        DispatchQueue.main.async {
            self.activityView!.center = UIApplication.scene.view.center
            UIApplication.scene.view.addSubview(self.activityView!)
            self.activityView!.startAnimating()
        }
    }
    
    private func hideActivityIndicator(){
        if (activityView != nil){
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.activityView?.stopAnimating()
                self.activityView?.removeFromSuperview()
            }
        }
    }
}
