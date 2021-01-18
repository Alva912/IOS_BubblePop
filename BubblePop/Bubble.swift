//
//  Bubble.swift
//  BubblePop
//
//  Created by ljh on 18/1/21.
//

import Foundation
import UIKit;

enum BubbleColor: String {
    case red;
    case pink;
    case green;
    case blue;
    case black;
}

extension UIButton {
    class func bubbleButton(frame: CGRect) -> UIButton {
        let bubble = UIButton(frame: frame);
        bubble.clipsToBounds = true;
        bubble.layer.cornerRadius = bubble.frame.width/2.0;
        bubble.layer.borderColor = UIColor.white.cgColor;
        bubble.layer.borderWidth = 2.0;
        bubble.backgroundColor = .red; // TODO
        bubble.setImage(UIImage(named: "b2.png"), for: .normal);
        return bubble;
    }
}
