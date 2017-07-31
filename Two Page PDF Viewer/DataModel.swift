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
    static var coverPage: Bool = false {
        didSet {
            let page = pdfView?.currentPage
            pdfView?.displaysAsBook = coverPage
            pdfView?.refresh()
            if let uPage = page {pdfView?.go(to: uPage)}
        }
    }
}
