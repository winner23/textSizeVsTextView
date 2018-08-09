//
//  ViewController.swift
//  textSizeVsTextView
//
//  Created by Volodymyr Viniarskyi on 8/7/18.
//  Copyright © 2018 Volodymyr Viniarskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var visableButton: UIButton!
    @IBOutlet weak var indicatorHeight: NSLayoutConstraint!
    @IBOutlet weak var indicatorTop: NSLayoutConstraint!
    @IBOutlet weak var attrIndicatorHeight: NSLayoutConstraint!
    @IBOutlet weak var attrIndicatorTop: NSLayoutConstraint!

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var attrLaberlHeight: NSLayoutConstraint!
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visableButton.isHidden = true
        
    }
    @IBAction func largeTextButtonTouched(_ sender: UIButton) {
        let text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."

//        let font = textView.font
        
        let strokeTextAttributes: [NSAttributedStringKey: Any] = [
            .strokeColor : UIColor.blue,
            .foregroundColor : UIColor.cyan,
            .strokeWidth : -2.0,
            .font : UIFont.boldSystemFont(ofSize: 14)
        ]
        let attributedText = NSAttributedString(string: text, attributes: strokeTextAttributes)
        textView.attributedText = attributedText
        label.attributedText = attributedText
        visableButton.isHidden = fitText(text, textView)
    }
    @IBAction func smallTextButtonTouched(_ sender: UIButton) {
        let text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        let strokeTextAttributes: [NSAttributedStringKey: Any] = [
            .strokeColor : UIColor.blue,
            .foregroundColor : UIColor.cyan,
            .strokeWidth : -2.0,
            .font : UIFont.boldSystemFont(ofSize: 12)
        ]
        let attributedText = NSAttributedString(string: text, attributes: strokeTextAttributes)
        textView.attributedText = attributedText
        label.attributedText = attributedText
        visableButton.isHidden = fitText(text, textView)
    }
    
    func fitText(_ text: String, _ textView: UITextView) -> Bool {
        var result: Bool = false
        let textViewContentSize = textView.contentSize
        print("textViewContentSize: \(textViewContentSize)")
        let attributes = textView.textContainer.size
        
        let insetsTextView = textView.textContainerInset
        let constraintRect = CGSize(width: attributes.width,
                                    height: CGFloat.greatestFiniteMagnitude)
        
        let rect = textView.attributedText.boundingRect(with: constraintRect,
                                         options: [.usesFontLeading, .usesLineFragmentOrigin, .truncatesLastVisibleLine],
//                                         attributes: textView.attributedText.attributes(at: 0, effectiveRange: nil),
                                         context: nil)

        attrIndicatorTop.constant = textView.frame.origin.y - insetsTextView.top
        
        attrIndicatorHeight.constant = ceil(rect.height)

        print("textView.textContainer.size: \(attributes)")
        print("attrText: \(rect)")
        
        let textRectSize = textView.text.boundingRect(with: constraintRect,
                                             options: [.usesLineFragmentOrigin, .usesFontLeading, .truncatesLastVisibleLine],
//                                             attributes: [NSFontAttributeName: font],
                                             context: nil)
        print("Text: \(textRectSize)")
        indicatorHeight.constant = ceil(textRectSize.height)
        indicatorTop.constant = textView.frame.origin.y - insetsTextView.top
        
        print("label.bounds.height: \(label.bounds.height)")
        print("preferredMaxLayoutWidth: \(label.preferredMaxLayoutWidth)")
        let neededSize = label.sizeThatFits(CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        print("neededSize: \(neededSize.height)")
        result = textRectSize.height < textViewContentSize.height
        return result
    }
    
    

}

