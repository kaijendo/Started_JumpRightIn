//
//  RatingController.swift
//  JumpRightIn
//
//  Created by Kai Jendo on 6/10/17.
//  Copyright © 2017 KaiJendo. All rights reserved.
//

import UIKit

@IBDesignable class RatingController: UIStackView {
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updatedButtonSelectionStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButtons()
    }
    
    //MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the button array \(ratingButtons)")
        }
        
        //Caculate the rating of the button array
        let selectedRating = index + 1
        if selectedRating ==  rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }

    //MARK: Private Methords
    private func setupButtons() {
        
        //Clear any exiting button
        for button in ratingButtons {
            addArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load button images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "ICC_filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "ICC_emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "ICC_highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {
            //Create the button
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            //Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Setup the button action
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Add button to stack
            addArrangedSubview(button)
            
            //Add new button to the ratting array button
            ratingButtons.append(button)
        }
        updatedButtonSelectionStates()
    }
    
    private func updatedButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            //If index of button is less a rating, that buttons should be selected.
            button.isSelected = index < rating
            var hintString: String?
            if index == rating + 1 {
                hintString = "The star is zero."
            } else {
                hintString = nil
            }
            
            let valueString: String
            switch rating {
            case 0:
                valueString = "The star is empty"
            case 1:
                valueString = "The star a"
            case 2:
                valueString = "The star at \(rating)"
            default:
                valueString = "\(rating) is set."
            }
            
            //Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            
        }
    }
}
