//
//  MasterViewController.swift
//  MyNextRead
//
//  Created by user204289 on 11/30/21.
//

import Foundation
import UIKit

class MasterViewController: UITableViewController {
    var HTObjectArray = [MyNextRead]()
    
    func convertToImage(imgURL:String) ->UIImage {
        let imgURL2 = URL(string:imgURL)!
        let imgData = try? Data(contentsOf: imgURL2)
        print(imgData ?? "Error")
        let img = UIImage(data: imgData!)
        return img!
    }
    
    func populateHTFromJSON() {
        let endPoint = "https://raw.githubusercontent.com/lhaque137/IT315/main/MyNextRead.json"
        let JSONURL = URL(string: endPoint)!
        let responseData = try? Data(contentsOf: JSONURL)
        print(responseData ?? "Error")
        print(responseData)
        if(responseData != nil) {
            let dictionary:NSDictionary = (try! JSONSerialization.jsonObject(with: responseData!, options:JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            print(dictionary)
            let htDictionary = dictionary["MyNextRead"]! as! [[String:AnyObject]]
            for index in 0...htDictionary.count - 1 {
                let singleHT = htDictionary[index]
                let ht = MyNextRead()
                ht.BookCover = singleHT["BookCover"]! as! String
                ht.BookTitle = singleHT["BookTitle"]! as! String
                ht.BookAuthor = singleHT["BookAuthor"]! as! String
                ht.BookSeries = singleHT["BookSeries"]! as! String
                ht.BookGenre = singleHT["BookGenre"]! as! String
                ht.BookRating = singleHT["BookRating"]! as! Double
                ht.BookPrice = singleHT["BookPrice"]! as! Double
                ht.BookLink = singleHT["BookLink"]! as! String
                ht.BookDescription = singleHT["BookDescription"]! as! String
                HTObjectArray.append(ht)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateHTFromJSON()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let destController = segue.destination as! ViewController
            let indexPath = tableView.indexPathForSelectedRow
            let bookObject = HTObjectArray[indexPath!.row]
            destController.passedMyNextRead = bookObject
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HTObjectArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookObject = HTObjectArray[indexPath.row]
        let bookTitle = bookObject.BookTitle
        let bookGenre = bookObject.BookGenre
        let bookImageURL = bookObject.BookCover
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellName", for: indexPath)
        cell.textLabel!.text = bookTitle
        cell.detailTextLabel!.text = bookGenre
        let img = convertToImage(imgURL: bookImageURL)
        cell.imageView?.image = img
        cell.imageView!.clipsToBounds = true
        cell.imageView!.layer.borderWidth = 1
        cell.imageView!.layer.borderColor = UIColor.gray.cgColor
        self.tableView.rowHeight = 80.00
        return cell
    }
}
