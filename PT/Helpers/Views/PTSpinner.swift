//
//  PTSpinner.swift
//  PT
//
//  Created by iOS Developer on 2/23/22.
//

import UIKit

final class PTSpinner: UIActivityIndicatorView {

    // MARK: - Style
    func set(style: UIActivityIndicatorView.Style = .medium, color: UIColor = .systemBlue) {
        
        self.style = style
        self.color = color
        
        hidesWhenStopped = true
        off()
    }
    
    // MARK: - Start/Stop Animation
    func on() {
        startAnimating()
    }
    
    func off() {
        stopAnimating()
    }
}
