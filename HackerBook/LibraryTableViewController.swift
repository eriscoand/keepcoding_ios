//
//  LibraryTableViewController.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 01/02/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

class LibraryTableViewController: UITableViewController {
    
    static let notificacionName = Notification.Name(rawValue: "BookDidChange")
    static let bookKey = Notification.Name(rawValue: "BookKey")
    
    let model: Library
    
    weak var delegate: LibraryTableViewControllerDelegate? = nil
    
    init(model: Library){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadLibrary(){
        model.loadLibrary()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tag  = getTag(forSection: indexPath.section)
        
        do{
            if let book = try model.book(atIndex: indexPath.row, forTag: tag){
                delegate?.libraryTableViewController(self, didSelectBook: book)
                notify(bookChanged: book)
            }
        }catch{
            fatalError("ERROR FATAL")
        }
    }

    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.tagCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.bookCount(forTag: getTag(forSection: section))
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return model.tagName(getTag(forSection: section))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellId = "BookCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        title = "HackerBooks"
        
        let tag  = getTag(forSection: indexPath.section)
        
        do{
            let book = try model.book(atIndex: indexPath.row, forTag: tag)
            
            if cell == nil{
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            }
            
            cell?.imageView?.image = UIImage.init(data: (book?.thumbnail)!)
            cell?.textLabel?.text = book?.title
            cell?.detailTextLabel?.text = book?.authorsString
            
        }catch{
            fatalError("ERROR FATAL")
        }
        
        return cell!
        
    }
    
    func getTag(forSection section: Int) -> Tag {
   
        return model.tags[section]
        
    }
}

extension LibraryTableViewController : BookViewControllerDelegate{
    
    func bookViewController(_ uVC: BookViewController){
        reloadLibrary()
    }
    
}

protocol LibraryTableViewControllerDelegate : class{
    
    func libraryTableViewController(_ uVC: LibraryTableViewController, didSelectBook book : Book)
    
}

extension LibraryTableViewController{
    
    func notify(bookChanged book : Book){
        
        let nc = NotificationCenter.default
        let notification = Notification(name: LibraryTableViewController.notificacionName, object: self, userInfo: [LibraryTableViewController.bookKey : book])
        
        nc.post(notification)
    }
    
}

