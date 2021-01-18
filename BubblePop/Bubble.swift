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
    class func bubbleButton(frame: CGRect, color: BubbleColor) -> UIButton {
        let bubble = UIButton(frame: frame);
        bubble.clipsToBounds = true;
        bubble.layer.cornerRadius = bubble.frame.width/2.0;
        bubble.layer.borderColor = UIColor.white.cgColor;
        switch color {
        case BubbleColor.red:
            bubble.backgroundColor = .red;
        case BubbleColor.pink:
            bubble.backgroundColor = .systemPink;
        case BubbleColor.green:
            bubble.backgroundColor = .green;
        case BubbleColor.blue:
            bubble.backgroundColor = .blue;
        case BubbleColor.black:
            bubble.backgroundColor = .black;
        }
        bubble.layer.borderWidth = 2.0;
        bubble.setImage(UIImage(named: "b2.png"), for: .normal);
        return bubble;
    }
}
