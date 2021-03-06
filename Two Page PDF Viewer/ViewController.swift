//
//  ViewController.swift
//  Two Page PDF Viewer
//
//  Created by Praveen on 7/22/17.
//  Copyright © 2017 praveen. All rights reserved.
//

import UIKit
import Speech
import PDFKit

class ViewController: UIViewController, UIDropInteractionDelegate, UIDocumentPickerDelegate {
    
    //MARK: IBOutlets
    @IBOutlet var pdfView: SmartPDFView!
    @IBOutlet var coverPage: UIBarButtonItem!
    @IBOutlet var toolbar: UIToolbar!
    
    var picker: UIDocumentPickerViewController?
    var twoPageTitle: String? = nil
    
    //MARK: IBActions
    @IBAction func setViewMode(_ sender: UIBarButtonItem) {
        toggleDisplayMode(sender)
    }
    
    @IBAction func setDocument(_ sender: UIBarButtonItem) {
        picker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: UIDocumentPickerMode.import)
        picker!.delegate = self
        present(picker!, animated: true) {self.picker = nil}
    }
    
    @IBAction func toggleBreaks(_ sender: UIBarButtonItem) {
        DataModel.showBreaks.toggle()
    }
    
    @IBAction func toggleScrolling(_ sender: UIBarButtonItem) {
        DataModel.scrolling.toggle()
    }
    
    @IBAction func fit(_ sender: UIBarButtonItem) {
        DataModel.fit()
    }
    
    @objc func swipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left || sender.direction == .up {
            DataModel.goToNextPage()
        } else if sender.direction == .right || sender.direction == .down {
            DataModel.goToPreviousPage()
        }
    }
    
    //MARK: View Controller
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        DataModel.pdfView = pdfView
        DataModel.pdfDocument = DataModel.pdfDocument
        
        pdfView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleToolbarDisplay)))
        for direction in [UISwipeGestureRecognizer.Direction.up, .down, .left, .right] {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
            swipeGesture.direction = direction
            pdfView.addGestureRecognizer(swipeGesture)
        }
        
        pdfView.addInteraction(UIDropInteraction(delegate: self))
        
        toggleDisplayMode(coverPage)
        
    }
    
    func toggleDisplayMode(_ sender: UIBarButtonItem) {
        if DataModel.coverPage == true {
            DataModel.coverPage = false
//            sender.title = "Cover page"
        } else {
            DataModel.coverPage = true
//            sender.title = "No cover page"
        }
    }
    
    @objc func toggleToolbarDisplay() {
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: UIView.AnimationCurve.easeInOut) {
            self.toolbar.alpha = self.toolbar.alpha == 0 ? 1 : 0
        }
        animator.startAnimation()
    }
    
    //MARK: Drop Delegate
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: ["com.adobe.pdf"])
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        let items = session.items.filter {$0.itemProvider.hasItemConformingToTypeIdentifier("com.adobe.pdf")}
        guard items.count > 0 else {return}
        let item = items[0]
        item.itemProvider.loadDataRepresentation(forTypeIdentifier: "com.adobe.pdf") {data, error in
            guard let uData = data, let document = PDFDocument(data: uData) else {return}
            DispatchQueue.main.async { DataModel.pdfDocument = document }
        }
    }
    
    //MARK: Document Picker Delegate
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let pdf = PDFDocument(url: urls[0]) else {return}
        DataModel.pdfDocument = pdf
    }
    
}
