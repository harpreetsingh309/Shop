//
//  CategoryViewModel.swift
//  Shop
//
//  Created by Harpreet on 10/05/21.
//

import Foundation


enum DataLoadingSate {
    case initial
    case loading
    case serverBusy
    case finished
    case failed
    case dataNotFound
    case error(String)
}

protocol CategoryViewModelDelegate: class {
    func viewModelStartFetching(_ viewModel: CategoryViewModel)
}

typealias DataLoadingClosure = ((DataLoadingSate)->Void)

class CategoryViewModel: NSObject {
    
    
    private(set) var page = 1
    private(set) var categories = [Objects]()
    
    var numberOFCategories: Int {
        categories.count
    }
    
    var loadingStateClosure: DataLoadingClosure?
    var isLoading = false
    
    var WEIGHT_CALCULATE: Double = 250
    var matchingCategory = "Air Conditioners"
    
    
    override init() {
        super.init()
        loadCategories(firstLoad: true, forPagination: false, reload: false)
    }
    
    //MARK:- fetch categories
    
    func loadCategories(firstLoad: Bool = false,forPagination: Bool = false,reload: Bool) {
        
        // server already loading the data
        // just return the thread from here
        if isLoading {
            loadingStateClosure?(.initial)
        }
        
        // this is first load of the api
        if firstLoad {
            loadingStateClosure?(.initial)
        }
        
        // api for categories
        var urlString = EndPoint.categories.baseUrl

        // if called for the pagination
        if forPagination {
            page += 1
            urlString += "\(page)"
        } else {
            // first page for loading
            urlString += "\(page)"
        }
        
        // final url
        guard let url = URL(string: urlString) else {
            loadingStateClosure?(.failed)
            return
        }

        isLoading = true
        loadingStateClosure?(.loading)
        ServiceManager.shared.getDataFromServer(url) { [weak self] (results) in
            guard let self = self else { return }
            self.isLoading = false
            switch results {
            case .success(let model):
                if let objs = model.objects {
                    // if reloading
                    if reload {
                        self.categories.removeAll()
                    }
                    for obj in objs {
                        self.categories.append(obj)
                    }
                    self.loadingStateClosure?(.finished)
                } else {
                    self.loadingStateClosure?(.dataNotFound)
                }
                break
            case .failure(let error):
                self.loadingStateClosure?(.error(error.localizedDescription))
                break
            }
        }
    }
}


//MARK:- CATEGORY DETAILS
extension CategoryViewModel {
    func categoryName(_ index:Int ) -> String? {
        if categories.indices.contains(index) {
            return categories[index].category
        }
        return nil
    }
    
    func categoryDescription(_ index:Int ) -> String? {
        if categories.indices.contains(index) {
            return categories[index].title
        }
        return nil
    }
    
    func categoryWeight(_ index: Int) -> String? {
        if categories.indices.contains(index) {
            let category = categories[index].category
            guard let weight = categories[index].weight else { return nil}
            if category == matchingCategory {
                guard let size = categories[index].size, let height = size.height, let width = size.width, let length = size.length else {
                    return "\(weight)"
                }
                let completeSize = ((width/100) * (height/100) * (length/100)) * WEIGHT_CALCULATE
                return "Calculated Weight: \(String(format: "%.2f", completeSize)) Kg"
            }
            return "Weight: \(weight) gm"
        }
        return nil
    }
}
