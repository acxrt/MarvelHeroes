//
//  HeroesDetailViewController.swift
//  MarvelHeroes
//
//  Created by Aina Cuxart on 22/5/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class HeroesDetailViewController: UIViewController {
    
    
    var heroe: Heroe = Heroe()
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var comicsLabel: UILabel!
    
    @IBOutlet var constraintsToAdd: [NSLayoutConstraint]!
    
    @IBOutlet var viewsToAddHeight: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageLink = ""
        if let path = heroe.thumbnail["path"], let imageExtension = heroe.thumbnail["extension"] {
            imageLink = "\(path).\(imageExtension)"
        }
        imageView.downloadedFrom(link: imageLink)
        nameLabel.text = heroe.name
        descriptionLabel.text = heroe.description
        comicsLabel.text = getComicsString()
        
        // Desription height
        var descriptionHeight = self.heightForView(label: descriptionLabel)
        if descriptionHeight < nameLabel.frame.size.height {
            descriptionHeight = nameLabel.frame.size.height
        }
        descriptionLabel.frame = CGRect(x: descriptionLabel.frame.origin.x, y: descriptionLabel.frame.origin.y, width: descriptionLabel.frame.size.width, height: descriptionHeight)
        
        // Comics height 
        var comicsHeight = self.heightForView(label: comicsLabel)
        if comicsHeight < nameLabel.frame.size.height {
            comicsHeight = nameLabel.frame.size.height
        }
        comicsLabel.frame = CGRect(x: comicsLabel.frame.origin.x, y: comicsLabel.frame.origin.y, width: comicsLabel.frame.size.width, height: comicsHeight)
        
        // Set border to imageView
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor(colorLiteralRed: 127.0/255.0, green: 127.0/255.0, blue: 127.0/255.0, alpha: 1).cgColor
        
        
        // Calculate total height of view
        var totalHeight: CGFloat = 0.0
        for constraint in constraintsToAdd {
            totalHeight += constraint.constant
        }
        
        for view in viewsToAddHeight {
            totalHeight += view.frame.height
        }
        
        contentViewHeightConstraint.constant = totalHeight
        
    }
    
    func getComicsString() -> String{
        
        var comicsString = ""
        
//        let comics: Array = heroe.comics["items"] as! Array<Any>
        
        if heroe.comics["items"] != nil {
            let items = JSON(heroe.comics["items"]!)
            
            var comics : Array<Any> = Array()
            
            var i = 0
            for (_, subJson) in items {
                if subJson["name"] != nil {
                    let comic = subJson["name"].stringValue
                    comics.append(comic)
                    if i != 0 {
                        comicsString.append(", ")
                    }
                    i += 1
                    comicsString.append(comic)
                }
            }
        }
        
        return comicsString
        
    }
    
    func heightForView(label: UILabel) -> CGFloat{
        
        label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        return label.frame.height
    }
    
}
