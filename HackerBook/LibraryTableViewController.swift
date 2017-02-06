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
    
    let nc = NotificationCenter.default
    
    weak var delegate: LibraryTableViewControllerDelegate? = nil
    
    //MARK: - Init and loading
    init(model: Library){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        deleteNotifications()
    }
    
    
    func deleteNotifications(){
        let nc = NotificationCenter.default
        nc.removeObserver(self.nc)
    }
    
    override func viewDidLoad() {
        nibRegistration()
        subscribe()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    func reloadLibrary(){
        model.loadLibrary()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tag  = getTag(forSection: indexPath.section)
        
        do{
            if let book = try model.book(atIndex: indexPath.row, forTag: tag){
                
                switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    let vC = BookViewController(model: book)
                    self.navigationController?.pushViewController(vC, animated: true)
                    break
                case .pad:
                    delegate?.libraryTableViewController(self, didSelectBook: book)
                    notify(bookChanged: book)
                    break
                default:
                    break
                    // Uh, oh! What could it be?
                }
                
                
            }
        }catch{
            fatalError("ERROR FATAL")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.tagCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.bookCount(forTag: getTag(forSection: section))
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BookTableViewCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return model.tagName(getTag(forSection: section))
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(model.bookCount(forTag: getTag(forSection: section)) == 0){
            return 0
        }
        return CGFloat(CONSTANTS.SECTION_HEIGHT)
    }
    
    private func nibRegistration(){
        let nib = UINib(nibName: "BookTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: BookTableViewCell.cellId)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        title = "DevBooks"
        
        let tag  = getTag(forSection: indexPath.section)
        
        do{
            let book = try model.book(atIndex: indexPath.row, forTag: tag)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.cellId, for: indexPath) as! BookTableViewCell
            
            cell.start(book: book!)
            return cell
            
            
        }catch{
            fatalError("Fatal Error parsing cell")
        }
        
        
    }
    
    func getTag(forSection section: Int) -> Tag {
        return model.tags[section]
    }
}

//MARK: - Delegate
protocol LibraryTableViewControllerDelegate : class{
    func libraryTableViewController(_ uVC: LibraryTableViewController, didSelectBook book : Book)
}

//MARK: - Extensions
extension LibraryTableViewController{
    
    //Notify that a book has been selected
    func notify(bookChanged book : Book){
        let nc = NotificationCenter.default
        let notification = Notification(name: LibraryTableViewController.notificacionName, object: self, userInfo: [LibraryTableViewController.bookKey : book])
        nc.post(notification)
    }
    
    //Subscribe to the notificacion when a book has been selected as favourite
    func subscribe(){
        nc.addObserver(forName: BookViewController.notificacionName,
                       object: nil, queue: OperationQueue.main,
                       using: {(note: Notification) in
                        self.reloadLibrary()
        })
    }
    
}

