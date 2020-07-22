//
//  ViewController.swift
//  AQNetworkKit
//
//  Created by cs4alhaider on 08/21/2019.
//  Copyright (c) 2019 cs4alhaider. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- Variables
    
    /// Basic UITableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    /// Basic indicator
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    /// Post array
    var data: [Posts] = [] {
        didSet {
            updateAfterFetchingData()
        }
    }
    
    // MARK:- Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding the tableView to the main view with auto layout
        addUI()
        
        // MARK:- Example 0 - Offline
        
//         Posts.getPostsFromJsonFile { [weak self] (result) in
//             switch result {
//             case .success(let data):
//                 self?.data = data
//                 self?.title = "\(data[0].title?.suffix(7) ?? "")"
//             case .failure(let error):
//                 print(error.localizedDescription)
//             }
//         }
        
        // MARK:- Example 1 - Offline
        
//         Posts.getPostsFromTextFile { [weak self] (result) in
//             switch result {
//             case .success(let data):
//                 self?.data = data
//                 self?.title = "\(data[0].title?.suffix(7) ?? "")"
//             case .failure(let error):
//                 print(error.localizedDescription)
//             }
//         }
        
        
        // MARK:- Example 2 - GET
        //
//        Posts.getPosts { [weak self] (result) in
//            switch result {
//            case .success(let data):
//                self?.data = data
//                self?.title = "\(data[0].title?.suffix(7) ?? "")"
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        Posts.getPost(with: 2) { [weak self] in
            guard let self = self else { return }
            if case .success(let post) = $0 {
                self.data = post
            }
        }
        
        // MARK:- Example 3 - GET
        //
        // Posts.getStringPosts { (result) in
        //     switch result {
        //     case .success(let string):
        //         print("My string" , string)
        //     case .failure(let error):
        //         print(error.localizedDescription)
        //     }
        // }
        
        
        // MARK:- Example 4 - POST
        //
        // Posts.pushNewPost(userId: 10,
        //                   id: 100923,
        //                   title: "Test new post",
        //                   body: "This is me trying to expline how you can use this 👀") { (result) in
        //                     switch result {
        //                     case .success(let responce):
        //                         print(responce.body ?? "")
        //                     case.failure(let error):
        //                         print(error.localizedDescription)
        //                     }
        // }
        
        
        // MARK:- Example 5 - DELETE
        //
        // Posts.deletePost(with: 5) { (result) in
        //     if case .success(let response) = result {
        //         print(response)
        //     }
        // }
        
        
        // MARK:- Example 6 - PUT (update)
        //
        // Posts.updatePost(post: 6, title: "New Title") { (result) in
        //     if case .success(let response) = result {
        //         print(response)
        //     }
        // }
    }
    
    // MARK:- Private methods
    
    /// Adding the UI to the main view with auto layout
    private func addUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
        view.addSubview(indicator)
        indicator.layer.zPosition = 1
        indicator.startAnimating()
    }
    
    private func updateAfterFetchingData() {
        guard !data.isEmpty else { return }
        tableView.reloadData()
        indicator.stopAnimating()
    }
}

// MARK:- tableView Methods

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = data[indexPath.row].body
        cell.detailTextLabel?.textColor = .gray
        return cell
    }
}

