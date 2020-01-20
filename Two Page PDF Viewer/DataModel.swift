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
            fit()
        }
    }
    
    static var coverPage: Bool = true {
        didSet { fit() }
    }
    
    static var showBreaks: Bool = true {
        didSet { fit() }
    }
    
    static var scrolling: Bool = true {
        didSet { fit() }
    }
    
    static func fit() {
        let pages = pdfView?.visiblePages
        
        let page: PDFPage?
        // If there are no visible pages, go back to the beginning.
        // If there is only one page it would cause a crash before.
        if pages == nil || pages!.count < 2 {
            page = nil
        } else {
            // This method will cause the page to continue to increase, so every other time, we reset it.
            var index = pages!.count/2
            if coverPage { index -= 1 }
            page = pages![index]
        }
        
        pdfView?.displaysAsBook = coverPage
        pdfView?.displayMode = scrolling ? .twoUpContinuous : .twoUp
        pdfView?.displayDirection = scrolling ? .vertical : .horizontal
        pdfView?.displaysPageBreaks = showBreaks
        pdfView?.pageShadowsEnabled = false
        pdfView?.refresh()
        if let page = page { pdfView?.go(to: page) }
    }
    
    static func goToPreviousPage() {
        if pdfView?.canGoToPreviousPage == true { pdfView?.goToPreviousPage(nil) }
    }
    
    static func goToNextPage() {
        if pdfView?.canGoToNextPage == true { pdfView?.goToNextPage(nil) }
    }
    
}
