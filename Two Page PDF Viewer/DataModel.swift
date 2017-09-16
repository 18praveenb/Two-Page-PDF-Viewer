//
//  DataModel.swift
//  Two Page PDF Viewer
//
//  Created by Praveen on 7/23/17.
//  Copyright © 2017 praveen. All rights reserved.
//

import Foundation
import PDFKit

class DataModel {
    
    static var pdfView: SmartPDFView? = nil
    
    static var pdfDocument: PDFDocument? = nil {
        didSet {
            pdfView?.document = pdfDocument
            pdfView?.displayMode = .twoUpContinuous
            pdfView?.refresh()
        }
    }
    
    static var coverPage: Bool = true {
        didSet { fit() }
    }
    
    static func fit() {
        let pages = pdfView?.visiblePages()
        
        let page: PDFPage?
        if pages == nil || pages!.count == 0 {
            page = nil
        } else {
            // This method will cause the page to continue to increase, so every other time, we reset it.
            var index = pages!.count/2
            if coverPage { index -= 1 }
            page = pages![index]
        }
        
        pdfView?.displaysAsBook = coverPage
        pdfView?.refresh()
        if let page = page { pdfView?.go(to: page) }
    }
    
}
