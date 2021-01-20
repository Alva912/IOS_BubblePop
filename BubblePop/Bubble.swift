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

struct BubblePos{
    var xAxis: Int;
    var yAxis: Int;
}

extension UIButton {
    class func bubbleButton(frame: CGRect) -> UIButton {
        let bubble = UIButton(frame: frame);
        bubble.clipsToBounds = true;
        bubble.layer.cornerRadius = bubble.frame.width/2.0;
        bubble.layer.borderColor = UIColor.white.cgColor;
        bubble.layer.borderWidth = 2.0;
        bubble.setImage(UIImage(named: "b2.png"), for: .normal);
        
        let colorPicker = Int.random(in:1...100);
        switch colorPicker {
        case 1...5: // 5%
            bubble.backgroundColor = .black;
        case 5...15: // 10%
            bubble.backgroundColor = .blue;
        case 15...30: // 15%
            bubble.backgroundColor = .green;
        case 30...60: // 30%
            bubble.backgroundColor = .systemPink;
        default: // 40%
            bubble.backgroundColor = .red;
        }
        
        return bubble;
    }
}
