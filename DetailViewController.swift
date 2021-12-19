//
//  DetailViewController.swift
//  MyNextRead
//
//  Created by user204289 on 11/30/21.
//

import Foundation
import UIKit
import AVKit
import WebKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var wkBrowser: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebKitContent()
    }
    
    func loadWebKitContent() {
        let bookLinkURL = URL(string: passedMyNextRead.BookLink)
        let request = URLRequest(url: bookLinkURL!)
        wkBrowser.load(request)
    }
    
    var passedMyNextRead:MyNextRead = MyNextRead()
    
}
