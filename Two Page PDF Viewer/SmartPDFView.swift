//
//  SmartPDFView.swift
//  Two Page PDF Viewer
//
//  Created by Praveen on 7/23/17.
//  Copyright © 2017 praveen. All rights reserved.
//

import Foundation
import PDFKit

class SmartPDFView: PDFView {
    
    /// refresh
    /// originally used when switching between 1 and 2 pages view was allowed
    /// to ensure the 2 page view was centered correctly
    func refresh() {
        self.autoScales = true
        let document = self.document
        self.document = nil
        self.autoScales = true
        self.document = document
        self.autoScales = true
    }
    
}
