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
    func refresh() {
        self.autoScales = true
        let document = self.document
        self.document = nil
        self.autoScales = true
        self.document = document
        self.autoScales = true
    }
    
}
