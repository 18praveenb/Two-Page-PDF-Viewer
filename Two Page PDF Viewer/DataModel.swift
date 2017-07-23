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
            pdfView?.refresh()
        }
    }
    static var viewMode: PDFDisplayMode = .singlePageContinuous {
        didSet {
            pdfView?.displayMode = viewMode
            pdfView?.refresh()
        }
    }
}
