//
//  OurNewsViewController.swift
//  AppForVK
//
//  Created by Mad Brains on 01.07.2020.
//  Copyright © 2020 Семериков Михаил. All rights reserved.
//

import Foundation
import UIKit

class OurNewsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
   
    private let newsService = VkNewsService()
    
    var vkNews: VkNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        newsService.loadVkNewsFeed(
            completion: { [weak self] news, error in
                guard error == nil else {
                    print("Some error in loading data")
                    return
                }
                
                self?.vkNews = news
                self?.tableView.reloadData()
            }
        )
    }
    
    private func configureTableView() {
        tableView.register(
            UINib(nibName: "OurNewsCell", bundle: nil),
            forCellReuseIdentifier: "OurNewsCellID"
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension OurNewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}

extension OurNewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vkNews?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OurNewsCellID", for: indexPath) as? OurNewsCell

        guard let uCell = cell, let uVkNews = vkNews else {
            print("There are some errors with reuse cell")
            return UITableViewCell()
        }
        
        let sourceId = uVkNews.items[indexPath.row].postSource_id
        
        let ownerGroup = uVkNews.groups.filter { $0.ownerId == -sourceId }.first
        let ownerUser = uVkNews.profiles.filter { $0.ownerId == sourceId }.first
        
        let owner = ownerGroup == nil ? ownerUser : ownerGroup
        
        uCell.configure(with: uVkNews.items[indexPath.row], owner: owner)
    
        return uCell
    }
    
}
