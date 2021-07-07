//
//  SearchController.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-02.
//

import UIKit

private let reuseIdentifier = "UserCell"

class SearchViewController: UITableViewController {
    
    // MARK: - properties
    
    private var users = [User]()
    private var filteredUsers = [User]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchActive : Bool {
        return searchController.isActive && !(searchController.searchBar.text ?? "").isEmpty
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchUsers()
        configureSearchController()
    }
    
    // MARK: - API
    
    private func fetchUsers(){
        UserService.fetchUsers(completion: { users in
            self.users = users
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Helpers
    
    func configureTableView(){
        view.backgroundColor = .white
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
        tableView.keyboardDismissMode = .onDrag
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filteredUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        let user = searchActive ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.user = user
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = searchActive ? filteredUsers[indexPath.row] : users[indexPath.row]
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredUsers = users.filter({
            $0.username.contains(searchText) ||
                $0.fullname.contains(searchText)
        })
        
        self.tableView.reloadData()
    }
}
