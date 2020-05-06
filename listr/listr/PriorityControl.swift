//
//  PriorityControl.swift
//  listr
//
//  Created by Regmi on 2020-05-05.
//  Copyright © 2020 Regmi. All rights reserved.
//

import UIKit

@IBDesignable class PriorityControl: UIStackView {
    
    private var priorityButtons = [UIButton]()
    var priority = 0
    
    @IBInspectable var circleSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var circleCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    @objc func priorityButtonTapped(button: UIButton) {
        print("Button pressed 👍")
    }
    
    // Private methods
    
    private func setupButtons() {
        //removes all old buttons
        for button in priorityButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        priorityButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledPriority = UIImage(named: "filledPriority", in: bundle, compatibleWith: self.traitCollection)
        let emptyPriority = UIImage(named:"emptyPriority", in: bundle, compatibleWith: self.traitCollection)
        let highlightedPriority = UIImage(named:"highlightPriority", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<circleCount {
            let button = UIButton()
            button.setImage(emptyPriority, for: .normal)
            button.setImage(filledPriority, for: .selected)
            button.setImage(highlightedPriority, for: .highlighted)
            button.setImage(highlightedPriority, for: [.highlighted, .selected])
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: circleSize.width).isActive = true
            button.widthAnchor.constraint(equalToConstant: circleSize.height).isActive = true
            button.addTarget(self, action: #selector(PriorityControl.priorityButtonTapped(button:)), for: .touchUpInside)
            addArrangedSubview(button)
            
            priorityButtons.append(button)
        }
    }
}
