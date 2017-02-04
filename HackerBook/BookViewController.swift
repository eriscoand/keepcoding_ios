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
    
    @IBOutlet weak var BookImage: UIImageView!
    @IBOutlet weak var BookTitle: UILabel!
    @IBOutlet weak var BookTags: UILabel!
    @IBOutlet weak var BookAuthors: UILabel!
    @IBOutlet weak var FavouriteButton: UIBarButtonItem!
    
    //MARK: - Init and loading
    init(model: Book){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //RELOAD VIEW
    func syncViewWithModel(){
        BookImage.image = UIImage.init(data: (model.thumbnail))
        BookTitle.text = model.title
        BookTags.text = model.tagsString
        BookAuthors.text = model.authorsString
        
        //Change text of favourite button.
        if(Favourites.isFavourite(b: model)){
            FavouriteButton.title = CONSTANTS.FAVOURITES_NAME
        }else{
            FavouriteButton.title = "!" + CONSTANTS.FAVOURITES_NAME
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncViewWithModel()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    //MARK: - Actions
    
    //Make a book favourite
    @IBAction func makeFavourite(_ sender: Any) {
        
        //Search if a book is on the list of favourites.
        if(Favourites.isFavourite(b: model)){
            Favourites.deleteFavourite(b: model)
        }else{
            Favourites.addFavourite(b: model)
        }
        syncViewWithModel()
        
        //Notify that a book has marked as favourite.
        notify()
        
    }
    
    //Open PDFViewController and load the pdf
    @IBAction func readBook(_ sender: Any) {
        let vC = PDFViewController(model: self.model)
        self.navigationController?.pushViewController(vC, animated: true)
    }
    

}

extension BookViewController{
    
    //Notify that a book has marked as favourite.
    func notify(){
        let nc = NotificationCenter.default
        let notification = Notification(name: BookViewController.notificacionName, object: self, userInfo: nil)
        nc.post(notification)
    }
    
}

//Library Delegate, change view from the selected book on the library
extension BookViewController : LibraryTableViewControllerDelegate{
    
    func libraryTableViewController(_ uVC: LibraryTableViewController, didSelectBook book : Book){
        model = book
        syncViewWithModel()
        edgesForExtendedLayout = .all
    }

}
