//
//  RatingControl.swift
//  FoodTracker
//
//  Created by UAG on 2019/7/7.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updataButtonSelectionStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 45, height: 45){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    //MRKE: initialization
    override init(frame: CGRect) {
       super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: private methods
    private func setupButtons(){
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load button image
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0 ..< starCount {
            // Create the button
            let button = UIButton()
            //button.backgroundColor = UIColor.red
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            //set the accessibility leve
            bundle.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //setup button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTaped(button:)),
                             for: .touchUpInside)
            
            //add the button to the stack
            addArrangedSubview(button)
            
            //add button to array
            ratingButtons.append(button)
            
        }
        
      updataButtonSelectionStates()
    }
    
    //MARK: button action
    @objc func ratingButtonTaped(button : UIButton){
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("the button, \(button) is no in the ratingButtons array: \(ratingButtons) ")
        }
        
        let selectedRating = index + 1
        
        if(selectedRating == rating)
        {
            rating = 0
        }
        else
        {
            rating = selectedRating
        }
    }
    
    func updataButtonSelectionStates()  {
        for(index , button) in ratingButtons.enumerated(){
            //if index of the button is less then rating,then button should be selected
            button.isSelected = index < rating
            let hintString : String?
            if(rating == index + 1){
                hintString = "Tap to reset the rating to zore"
            }
            else{
                hintString = nil
            }
            
            //calculate the value string
            let valueString : String
            switch(rating){
            case 0 : valueString = "No Rating set"
            case 1 : valueString = "1 star set"
            default: valueString = "\(rating) star set"
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
