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
    static var pdfView: PDFView? = nil
    static var pdfDocument: PDFDocument? = nil {
        didSet {
            pdfView?.displayMode = .twoUpContinuous
            pdfView?.autoScales = true
            pdfView?.document = pdfDocument
            pdfView?.autoScales = true
        }
    }
}
