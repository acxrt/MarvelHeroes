//
//  HeroeCell.swift
//  MarvelHeroes
//
//  Created by Aina Cuxart on 22/5/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import UIKit

class HeroeCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var heroeInfo: Heroe = Heroe()
    
}
