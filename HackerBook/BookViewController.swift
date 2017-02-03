//
//  BookViewController.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 03/02/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    var model : Book
    
    static let notificacionName = Notification.Name(rawValue: "FavouritesDidChange")
    
    weak var delegate: BookViewControllerDelegate? = nil
    
    @IBOutlet weak var BookImage: UIImageView!
    @IBOutlet weak var BookTitle: UILabel!
    @IBOutlet weak var BookTags: UILabel!
    @IBOutlet weak var BookAuthors: UILabel!
    @IBOutlet weak var FavouriteButton: UIBarButtonItem!
    
    init(model: Book){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func makeFavourite(_ sender: Any) {
        
        if(Favourites.isFavourite(b: model)){
            Favourites.deleteFavourite(b: model)
        }else{
            Favourites.addFavourite(b: model)
        }
        syncViewWithModel()
                
        delegate?.bookViewController(self)
        notify()
        
    }
    
    @IBAction func readBook(_ sender: Any) {
    }
    
    func syncViewWithModel(){
        BookImage.image = UIImage.init(data: (model.thumbnail))
        BookTitle.text = model.title
        BookTags.text = model.tagsString
        BookAuthors.text = model.authorsString

        if(Favourites.isFavourite(b: model)){
            FavouriteButton.title = CONSTANTS.FAVOURITES_NAME
        }else{
            FavouriteButton.title = "!" + CONSTANTS.FAVOURITES_NAME
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncViewWithModel()
        edgesForExtendedLayout = .all
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

protocol BookViewControllerDelegate : class{
    
    func bookViewController(_ uVC: BookViewController)
    
}

extension BookViewController{
    
    func notify(){
        
        let nc = NotificationCenter.default
        let notification = Notification(name: BookViewController.notificacionName, object: self, userInfo: nil)
        
        nc.post(notification)
    }
    
}

extension BookViewController : LibraryTableViewControllerDelegate{
    
    func libraryTableViewController(_ uVC: LibraryTableViewController, didSelectBook book : Book){
        model = book
        syncViewWithModel()
        edgesForExtendedLayout = .all
    }

}
