//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Ashley Jelks on 12/15/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    //MARK: Properties
    
    var spacing = 5
    var stars = 5
    
    var rating = 0 {
    
        didSet {
            
            setNeedsLayout()
        }
            
    }
    var ratingButtons = [UIButton]()
    
    
    //MARK: Initialization
    
    override func layoutSubviews() {
        
        //Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        //Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
            /*^^ This code creates a frame, and uses a for-in loop to iterate over all of the buttons to set their frames.
            
            The enumerate() method returns a collection that contains elements in the ratingButtons array paired with their indexes. This is a collection of tuples—groupings of values—and in this case, each tuple contains an index and a button. For each tuple in the collection, the for-in loop binds the values of the index and button in that tuple to local variables, index and button. You use the index variable to compute a new location for the button frame and set it on the button variable. The frame locations are set equal to a standard button size of 44 points and 5 points of padding, multiplied by index.*/
        }
        
        updateButtonSelectionStates()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<stars {
            
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            ratingButtons += [button]
            //^^As you create each button, you add it to the ratingButtons array to keep track of it.
            addSubview(button)
    }
    
    }
    
    override func intrinsicContentSize() -> CGSize {
        
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    //MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        
        /* The indexOf(_:) method attempts to find the selected button in the array of buttons and to return the index at which it was found. This method returns an optional Int because the instance you’re searching for might not exist in the collection you’re searching. However, because the only buttons that trigger this action are the ones you created and added to the array yourself, you can be sure that searching for the button will return a valid index. In this case, you can use the force unwrap operator (!) to access the underlying index value. You add 1 to that index to get the corresponding rating. You need to add 1 because arrays are indexed starting with 0. */
    }
    
    func updateButtonSelectionStates() {
        //This is a helper method that you’ll use to update the selection state of the buttons.
        
        for (index, button) in ratingButtons.enumerate() {
            
            //If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
        
    }

}
