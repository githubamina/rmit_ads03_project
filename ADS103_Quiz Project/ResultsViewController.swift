//
//  ResultsViewController.swift
//  ADS103_Quiz Project
//
//  Created by Amina on 30/4/18.
//  Copyright © 2018 Amina. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    //Outlets to the two labels in the ResultsViewController
    @IBOutlet weak var resultAnswerLabel: UILabel!
    
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    //Variable to store the answers array passed in from the quiz view controllers
    var responses: [Answer]!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Call the function to display the user's result
        calculateOption()
        
        //Hide the back button to prevent the user from going back into the quiz
        navigationItem.hidesBackButton = true
        
    }
    
    //Function which calculates the most appropriate result based on the user's answers and updates the two labels accordingly
    func calculateOption() {
        var frequencyOfAnswers: [ResultType: Int] = [:]
        
        let responseTypes = responses.map {$0.type}
        
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by:
        { (pair1, pair2) -> Bool in return pair1.value > pair2.value})
        
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        resultAnswerLabel.text = "We recommend: "
        resultDefinitionLabel.text = mostCommonAnswer.definition
        
    }




}
