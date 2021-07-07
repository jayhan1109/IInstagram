//
//  SearchController.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-02.
//

import UIKit

private let reuseIdentifier = "UserCell"

class SearchController: UITableViewController {
    
    // MARK: - properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    // MARK: - Helpers
    
    func configureTableView(){
        view.backgroundColor = .white
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
    }
}

// MARK: - UITableViewDataSource

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}
