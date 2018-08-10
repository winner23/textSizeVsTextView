//
//  ViewController.swift
//  textSizeVsTextView
//
//  Created by Volodymyr Viniarskyi on 8/7/18.
//  Copyright © 2018 Volodymyr Viniarskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var scrollingView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // we will set the contentSize after determining how many pages get filled with text
        //scrollingView.contentSize = CGSize(width: CGFloat((view.bounds.size.width - 20) * pageNumber), height: CGFloat(view.bounds.size.height - 20))
        
        scrollingView.isPagingEnabled = true
        
        let textString = "NOW, what I want is, Facts.  Teach these boys and girls nothing but Facts.  Facts alone are wanted in life.  Plant nothing else, and root out everything else.  You can only form the minds of reasoning animals upon Facts: nothing else will ever be of any service to them.  This is the principle on which I bring up my own children, and this is the principle on which I bring up these children.  Stick to Facts, sir!’ The scene was a plain, bare, monotonous vault of a school-room, and the speaker’s square forefinger emphasized his observations by underscoring every sentence with a line on the schoolmaster’s sleeve.  The emphasis was helped by the speaker’s square wall of a forehead, which had his eyebrows for its base, while his eyes found commodious cellarage in two dark caves, overshadowed by the wall.  The emphasis was helped by the speaker’s mouth, which was wide, thin, and hard set.  The emphasis was helped by the speaker’s voice, which was inflexible, dry, and dictatorial.  The emphasis was helped by the speaker’s hair, which bristled on the skirts of his bald head, a plantation of firs to keep the wind from its shining surface, all covered with knobs, like the crust of a plum pie, as if the head had scarcely warehouse-room for the hard facts stored inside.  The speaker’s obstinate carriage, square coat, square legs, square shoulders,—nay, his very neckcloth, trained to take him by the throat with an unaccommodating grasp, like a stubborn fact, as it was,—all helped the emphasis. ‘In this life, we want nothing but Facts, sir; nothing but Facts!’ The speaker, and the schoolmaster, and the third grown person present, all backed a little, and swept with their eyes the inclined plane of little vessels then and there arranged in order, ready to have imperial gallons of facts poured into them until they were full to the brim."
        
        let textStorage = NSTextStorage(string: textString)
        let textLayout = NSLayoutManager()
        textStorage.addLayoutManager(textLayout)
//        textLayout.delegate = self
        scrollingView.delegate = self
        var r = CGRect(x: 0, y: 0, width: scrollingView.frame.size.width, height: scrollingView.frame.size.height)
        
        var i: Int = 0
        
        // this is what we'll use to track the "progress" of filling the "screens of textviews"
        // each time through, we'll get the last Glyph rendered...
        // if it's equal to the total number of Glyphs, we know we're done
        var lastRenderedGlyph = 0
        
        while lastRenderedGlyph < textLayout.numberOfGlyphs {
            
            let textContainer = NSTextContainer(size: scrollingView.frame.size)
            textLayout.addTextContainer(textContainer)
            
            let textView = UITextView(frame: r, textContainer: textContainer)
            
            r.origin.x += r.width
            
            textView.font = .systemFont(ofSize: 14)
            
            textView.tag = i
            
            i += 1
            
            scrollingView.addSubview(textView)
            
            // get the last Glyph rendered into the current textContainer
            lastRenderedGlyph = NSMaxRange(textLayout.glyphRange(for: textContainer))
            
        }
        
        // use the last textView rect to set contentSize
        scrollingView.contentSize = CGSize(width: r.origin.x, height: r.size.height)
        
        pageControll.numberOfPages = i
        pageControll.currentPage = 0
        print("Actual number of pages =", i)
    }

}
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControll.currentPage = Int(round(value))
        print(pageControll.currentPage)
    }
}

extension ViewController: UIPageViewControllerDelegate {
    valuech
}

