//
//  BookTableViewCell.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 04/02/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    static let cellId = "BookTableViewCellId"
    static let cellHeight : CGFloat = 100

    @IBOutlet weak var authorsView: UILabel!
    @IBOutlet weak var tagsView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    
    var model : Book?
    
    private
    let _nc = NotificationCenter.default
    private
    var _bookObserver : NSObjectProtocol?
    
    func start(book: Book){
        model = book
        syncModel()
    }
    
    func stop(){
        if let observer = _bookObserver{
            _nc.removeObserver(observer)
            _bookObserver = nil
            model = nil
        }
    }
    
    //MARK: - Lifecycle
    
    // Sets the view in a neutral state, before being reused
    override func prepareForReuse() {
        stop()
        syncModel()
    }
    
    deinit {
        stop()
    }
    
    //MARK: - Utils
    private
    func syncModel(){
        
        if let image = UIImage(data: (model?.thumbnail)!){
            imageViewCell.image = image
        }
        titleView.text = model?.title
        authorsView.text = model?.authorsString
        tagsView.text = model?.tagsString
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
