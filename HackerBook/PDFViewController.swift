//
//  PDFViewController.swift
//  HackerBook
//
//  Created by Eric Risco de la Torre on 03/02/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {
        
    var model : Book
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    
    let nc = NotificationCenter.default

    //MARK: - Init and reload
    init(model: Book){
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
        super.viewDidLoad()
        
        //Subscribe to the book selection of the LibraryTableViewController
        subscribe()
        syncViewWithModel()
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        webView.delegate = self
    }
    
    func syncViewWithModel(){
        do{
            webView.isHidden = true
            spinner.isHidden = false
            spinner.startAnimating()
            
            //loads the PDF from the json's url
            let pdf = try getFileFrom(stringUrl: model.urlPDF)
            let url = try getInternalUrl(file: model.urlPDF)
            
            webView.load(pdf, mimeType: "application/pdf", textEncodingName: "", baseURL: url.deletingLastPathComponent())
            
        }catch{
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        unsubscribe()
    }

}

extension PDFViewController {
    func subscribe(){
        nc.addObserver(forName: LibraryTableViewController.notificacionName,
                       object: nil, queue: OperationQueue.main,
                       using: {(note: Notification) in
                        let userInfo = note.userInfo
                        let book = userInfo?[LibraryTableViewController.bookKey]
                        self.model = book as! Book
                        
                        self.syncViewWithModel()
                        
        })
    }
    
    func unsubscribe(){
        let nc = NotificationCenter.default
        nc.removeObserver(self)
    }
}

extension PDFViewController: UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        webView.isHidden = true
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.isHidden = false
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
}
