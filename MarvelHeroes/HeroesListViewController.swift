//
//  HeroesListViewController.swift
//  MarvelHeroes
//
//  Created by Aina Cuxart on 22/5/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import UIKit

class HeroesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var heroesList: Array<Heroe> = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 70.0
        
        HeroesService.allHeroes(success: {list in
            
            self.heroesList = list as! Array<Heroe>
            self.tableView.reloadData()
            
        }) { (error) in
            print(error)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.heroesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let heroe: Heroe = heroesList[indexPath.row]
        var thumbnail = ""
        
        if let path = heroe.thumbnail["path"], let imageExtension = heroe.thumbnail["extension"]{
            thumbnail = "\(path).\(imageExtension)"
        }
        
        
        let cell: HeroeCell = tableView.dequeueReusableCell(withIdentifier: "heroeCell", for: indexPath) as! HeroeCell
        
        cell.heroeInfo = heroe
        cell.nameLabel.text = heroe.name
        cell.thumbnailView.image = nil
        cell.thumbnailView.downloadedFrom(link: thumbnail)
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}
