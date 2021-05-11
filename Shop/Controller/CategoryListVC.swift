//
//  CategoryListVC.swift
//  Shop
//
//  Created by Harpreet on 10/05/21.
//

import UIKit

class CategoryListVC: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var categoryViewModel = CategoryViewModel()

    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelObservation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    // ------------- END LIFE CYCLE ----------
    
    private func viewModelObservation() {
        categoryViewModel.loadingStateClosure = { [weak self] (state) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch state {
                case .initial:
                    self.loader.isHidden = false
                    self.loader.startAnimating()
                case .loading:
                    break
                case .serverBusy:
                    break
                case .finished:
                    self.loader.stopAnimating()
                    self.loader.isHidden = true
                    self.listTableView.reloadData()
                case .failed:
                    self.loader.stopAnimating()
                    self.loader.isHidden = true
                case .dataNotFound:
                    self.loader.stopAnimating()
                    self.loader.isHidden = true
                case .error(_):
                    self.loader.stopAnimating()
                    self.loader.isHidden = true
                }
            }
        }
    }
}

//MARK:- UITableViewDataSource
extension CategoryListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryViewModel.numberOFCategories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryListCell.cellID) as? CategoryListCell else { return UITableViewCell() }
        cell.categoryNameLabel.text = categoryViewModel.categoryName(indexPath.row)
        cell.categoryDescLabel.text = categoryViewModel.categoryDescription(indexPath.row)
        cell.itemWeightLabel.text = categoryViewModel.categoryWeight(indexPath.row)
        return cell
    }
}
