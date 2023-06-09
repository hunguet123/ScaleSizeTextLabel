//
//  ViewController.swift
//  ChangeSizeLabel
//
//  Created by Hà Quang Hưng on 09/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    var defaultSizeLabel = 0.0
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = """
adfjlsdfjlksjdlfjlsajfagffffffff.
ladjsfsd.
"""
        defaultSizeLabel = label.font.pointSize
        setLabel()
    }
    
    func setLabel() {
        DispatchQueue.main.async {
            let arraySentence = self.label.text?.splitSentences()
            var min = 10000000.0
            var text = ""
            arraySentence?.forEach({ element in
                let size =  element.sizeStringWithFont(self.defaultSizeLabel)
                if size.width < min && !element.isEmpty {
                    min = size.width
                    text = element
                }
            })
            
            if Int(min/self.label.bounds.width) > self.count {
                self.count += 1
                self.setFontSizeLabel(text)
            }
        }
    }
    
    func setFontSizeLabel(_ text: String) {
        let fontSize = text.calculateFontSizeToFitScreen(initialFontSize: defaultSizeLabel, maxWidth: label.bounds.width)
        label.font = UIFont.systemFont(ofSize: fontSize)
        self.label.sizeToFit()
    }
}
