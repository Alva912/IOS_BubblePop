//
//  Bubble.swift
//  BubblePop
//
//  Created by ljh on 18/1/21.
//

import Foundation
import UIKit;

enum BubbleColor: String {
    case black = "BubbleBlack";
    case blue = "BubbleBlue";
    case green = "BubbleGreen";
    case pink = "BubblePink";
    case red = "BubbleRed";
}

extension UIColor {
    static func bubbleColor(_ name: BubbleColor) -> UIColor? {
        return UIColor(named: name.rawValue);
    }
}

struct BubblePos{
    var xAxis: Int;
    var yAxis: Int;
}

extension UIButton {
    class func bubbleButton(frame: CGRect) -> UIButton {
        let bubble = UIButton(frame: frame);
        bubble.clipsToBounds = true;
        bubble.layer.cornerRadius = bubble.frame.width/2.0;
        bubble.setBackgroundImage(UIImage(named: "b2.png"), for: .normal);
        
        let colorPicker = Int.random(in:1...100);
        switch colorPicker {
        case 1...5: // 5%
            bubble.backgroundColor = .bubbleColor(.black);
        case 5...15: // 10%
            bubble.backgroundColor = .bubbleColor(.blue);
        case 15...30: // 15%
            bubble.backgroundColor = .bubbleColor(.green);
        case 30...60: // 30%
            bubble.backgroundColor = .bubbleColor(.pink);
        default: // 40%
            bubble.backgroundColor = .bubbleColor(.red);
        }
        
        return bubble;
    }
}
