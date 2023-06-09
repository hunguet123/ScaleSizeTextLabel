//
//  UtilsClass.swift
//  ChangeSizeLabel
//
//  Created by Hà Quang Hưng on 09/06/2023.
//

import Foundation
import UIKit

extension String {
    func sizeStringWithFont( _ fontSize: Double)-> CGSize {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let textString = self
        return (textString as NSString).size(withAttributes: attributes)
    }
    
    func isSentenceComplete(_ sentence: String) -> Bool {
        let punctuationMarks: [Character] = [".", "!", "?"]
        
        if let lastCharacter = sentence.last, punctuationMarks.contains(lastCharacter) {
            return true
        }
        
        return false
    }
    
    func calculateFontSize(maxWidth: CGFloat, font: UIFont) -> CGFloat {
        var fontSize: CGFloat = 100 // Giá trị khởi tạo font size
        
        while true {
            let fontAttributes = [NSAttributedString.Key.font: font.withSize(fontSize)]
            let size = NSString(string: self).size(withAttributes: fontAttributes)
            
            if size.width <= maxWidth {
                break
            }
            
            fontSize -= 1 // Giảm font size cho đến khi chiều rộng phù hợp
        }
        
        return fontSize
    }
    
    func splitSentences() -> [String] {
        let separators: [Character] = [".", "!", "?"]
        let text = self
        return text.components(separatedBy: CharacterSet(charactersIn: String(separators)))
    }
    
    func calculateFontSizeToFitScreen(initialFontSize: CGFloat, maxWidth: CGFloat) -> CGFloat {
        let label = UILabel()
        label.text = self
        label.font = UIFont.systemFont(ofSize: initialFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.frame.size = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        label.sizeToFit()
        
        let scaledFontSize = initialFontSize * (maxWidth / label.frame.width)
        return min(initialFontSize, scaledFontSize)
    }

}
