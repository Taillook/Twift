//
//  TweetDetailViewController.swift
//  Twift
//
//  Created by Taillook on 2017/10/01.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import UIKit
import SDWebImage
import ObjectMapper

class TweetDetailViewController: UITableViewController {
    var data: [Tweet] = []
    
    override func viewWillAppear(_ animated: Bool) {
        updateTweets()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI() {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.refreshControlValueChanged(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func updateTweets() {
        OAuthTwitter().fetchHomeTimeLine() { jsonString in
            self.data = Mapper<Tweet>().mapArray(JSONString: jsonString)!
            self.tableView.reloadData()
            print(self.data.count)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)

        return cell
    }
    
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        print(data[indexPath.row].text!)
    }
}
