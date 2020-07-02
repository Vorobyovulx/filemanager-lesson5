//
//  NewsTabViewController.swift
//  AppForVK
//
//  Created by Mad Brains on 01.07.2020.
//  Copyright © 2020 Семериков Михаил. All rights reserved.
//

import Foundation
import UIKit

class NewsTabViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    let newsService = VkNewsService()
    var vkNews: VkNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        newsService.loadVkNewsFeed(
            completion: { [weak self] news, error in
                guard let _ = error else {
                    print(news?.items.count)
                    self?.vkNews = news
                    self?.tableView.reloadData()
                    return
                }
                
                print("Some error")
            }
        )
        
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "NewsTabCell", bundle: nil), forCellReuseIdentifier: "NewsTabCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension NewsTabViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}

extension NewsTabViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vkNews?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTabCell", for: indexPath) as? NewsTabCell
 
        guard let uCell = cell, let uVkNews = vkNews else {
            print("Error with news cell")
            return UITableViewCell()
        }
    
        let sourceId = uVkNews.items[indexPath.row].postSource_id
    
        let ownerGroup = uVkNews.groups.filter { $0.ownerId == -sourceId }.first
        let ownerUser = uVkNews.profiles.filter { $0.ownerId == sourceId }.first
        
        let owner = ownerGroup == nil ? ownerUser : ownerGroup
        
        uCell.configure(with: vkNews?.items[indexPath.row], owner: owner)
        
        return uCell
    }
    
    
}
