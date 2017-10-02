//
//  SendTweetViewController .swift
//  Twift
//
//  Created by Taillook on 2017/10/02.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import UIKit

class SendTweetViewController: UIViewController {
    @IBAction func tappedTweet(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func tappedClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("aaaa")
    }
}
