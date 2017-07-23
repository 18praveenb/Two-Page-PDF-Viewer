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

class ViewController: UIViewController {
    
    @IBOutlet var pdfView: PDFView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        DataModel.pdfView = pdfView
        pdfView.document = DataModel.pdfDocument ?? PDFDocument(url: Bundle.main.url(forResource: "PDF", withExtension: "pdf")!)!
        
        pdfView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchUp)))
        
        refreshViewMode()
        
    }
    
    @objc func touchUp() {
//        pdfView.autoScales = true
//        pdfView.document = pdfView.document
//        pdfView.autoScales = true
    }
    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        refreshViewMode()
//    }
//
//    func refreshViewMode() {
//        let landscape = UIDeviceOrientationIsLandscape(UIDevice.current.orientation)
//        pdfView.displayMode = landscape ? .twoUpContinuous : .singlePageContinuous
//        pdfView.autoScales = true
//        pdfView.document = pdfView.document
//        pdfView.autoScales = true
//    }

}

class Speaker {
    static var speaker = AVSpeechSynthesizer()
    class func speak(_ text: String) {
        speaker.speak(AVSpeechUtterance(string: text))
    }
}
