//
//  HeroesListViewController.swift
//  MarvelHeroes
//
//  Created by Aina Cuxart on 22/5/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import UIKit

class HeroesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var heroesList: Array<Heroe> = Array()
    var heroesFiltered: Array<Heroe> = Array()
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 70.0
        
        searchBar.delegate = self
        
        HeroesService.allHeroes(success: {list in
            
            self.heroesList = list as! Array<Heroe>
            self.heroesFiltered = list as! Array<Heroe>
            self.tableView.reloadData()
            
        }) { (error) in
            print(error)
        }
        
        navigationItem.title = "Heroes"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.contentInset = UIEdgeInsets.zero
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        deregisterFromKeyboardNotifications()

    }
    
    // MARK - Table View Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            return heroesFiltered.count
        }
        
        return heroesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var heroe: Heroe = Heroe()
        if(searchActive) {
            heroe = heroesFiltered[indexPath.row]
        } else{
            heroe = heroesList[indexPath.row]
        }
        
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
    
    
    // MARK - Search Bar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        heroesFiltered = heroesList
        tableView.reloadData()
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        heroesFiltered = heroesList.filter({ (heroe) -> Bool in
            let tmp: String = heroe.name
            return tmp.localizedCaseInsensitiveContains(searchText)
            
        })
        if(heroesFiltered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        tableView.reloadData()
    }
    
    
    
    //MARK - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" , let detailScene = segue.destination as? HeroesDetailViewController  {
            
            if let selectedCellPath = tableView.indexPathForSelectedRow {
                let selectedCell: HeroeCell = tableView.cellForRow(at: selectedCellPath) as! HeroeCell
                
                    detailScene.heroe = selectedCell.heroeInfo
            }
        }
    }
    
    // MARK: - Keyboard
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    
    func keyboardWasShown(notification: NSNotification){
        
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        tableView.contentInset = contentInsets
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        
        let contentInsets : UIEdgeInsets = UIEdgeInsets.zero
        
        tableView.contentInset = contentInsets
        
        self.view.endEditing(true)
        
    }
}

