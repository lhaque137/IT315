//
//  ViewController.swift
//  MyNextRead
//
//  Created by user204289 on 9/22/21.
//  This app is developed as an educational project. Certain materials are included under the Fair Use Exemption of the U.S. Copyright Law and have been prepared according to the multimedia fair use guidelines and are restricted from further use.

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var mySound:AVAudioPlayer!

    @IBOutlet weak var lblCover: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblAuthor: UILabel!
    
    @IBOutlet weak var lblSeries: UILabel!
    
    @IBOutlet weak var lblGenre: UILabel!
    
    @IBOutlet weak var lblRating: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var textDescription: UITextView!
    
    var HTObjectArray = [MyNextRead]()
    var passedMyNextRead:MyNextRead = MyNextRead()
    var randomGlobalObject:MyNextRead = MyNextRead()
    
    func setLabels() {
        let randomHT = passedMyNextRead
        randomGlobalObject = randomHT
        lblTitle.text = randomHT.BookTitle
        lblAuthor.text = randomHT.BookAuthor
        lblSeries.text = randomHT.BookSeries
        lblGenre.text = randomHT.BookGenre
        lblRating.text = "\(randomHT.BookRating ?? 0.0)"
        lblPrice.text = "\(randomHT.BookPrice ?? 0.0)"
        textDescription.text = randomHT.BookDescription
        
        let imgName = randomHT.BookCover
        lblCover.image=convertToImage(imgURL: imgName)
        lblCover.clipsToBounds = true
        lblCover.layer.borderWidth = 1
        lblCover.layer.borderColor = UIColor.gray.cgColor
        
        mySound.play()
    }
    
    func convertToImage(imgURL:String) ->UIImage {
        let imgURL2 = URL(string:imgURL)!
        let imgData = try? Data(contentsOf: imgURL2)
        print(imgData ?? "Error")
        let img = UIImage(data: imgData!)
        return img!
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        lblCover.alpha = 0.0
        lblTitle.alpha = 0.0
        lblAuthor.alpha = 0.0
        lblSeries.alpha = 0.0
        lblGenre.alpha = 0.0
        lblRating.alpha = 0.0
        lblPrice.alpha = 0.0
        textDescription.alpha = 0.0
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        UIView.animate(withDuration: 2.0, animations: {
            self.lblCover.alpha = 1.0
            self.lblTitle.alpha = 1.0
            self.lblAuthor.alpha = 1.0
            self.lblSeries.alpha = 1.0
            self.lblGenre.alpha = 1.0
            self.lblRating.alpha = 1.0
            self.lblPrice.alpha = 1.0
            self.textDescription.alpha = 1.0
        })
        setLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showSubDetail") {
            let destController = segue.destination as! DetailViewController
            destController.passedMyNextRead = self.passedMyNextRead
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySound = try? AVAudioPlayer(contentsOf:URL(fileURLWithPath: Bundle.main.path(forResource: "bell", ofType: "wav")!))
        setLabels()
    }
}

