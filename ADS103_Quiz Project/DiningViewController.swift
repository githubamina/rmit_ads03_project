//
//  DiningViewController.swift
//  ADS103_Quiz Project
//
//  Created by Amina on 30/4/18.
//  Copyright © 2018 Amina. All rights reserved.
//

import UIKit

class DiningViewController: UIViewController {
    
    //Outlets to DiningViewController's views, buttons, labels, switches and sliders
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    //Variable to store unshuffled Dining Quiz questions
    var questions = diningQuestions
    
    
    //Variable to store array of shuffled Dining Quiz questions
    var currentQuestions: [Question]!
    
    
    //Variable to keep track of the number of questions the user has answered
    var questionIndex = 0

    
    //Variable to store the answer options of the current question
    var currentAnswers: [Answer] = []
    
    //Variable to store the answers the user chooses so they can be passed to the ResultsViewController
    var answersChosen: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Shuffle the questions and store them in currentQuestions
        currentQuestions = shuffle(questionArray: questions)
    
        //Call updateUI() so the quizzes are ready for the user to use
        updateUI()
      
    }

    
    func updateUI() {
        //Hide the stack views at first so the UI is clean
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        
        //Constant to store the current question the user is on
        let currentQuestion = currentQuestions[questionIndex]
        
        
        //Check if the current question is ranged.
        //If not then shuffle the current question's answers and store them in currentAnswers
        //Otherwise, leave the answers unshuffled and store them in currentAnswers
        if currentQuestion.type != .ranged {
            currentAnswers = shuffleAnswers(answerArray: currentQuestion.answers)
        } else {
            currentAnswers = currentQuestion.answers
        }
        
        //Constant to store the user's current progress through the quiz
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        //Update the navbar title to correspond the current question's index
        navigationItem.title = "Question #\(questionIndex + 1)"
        //Update the question label to be the current question's text
        questionLabel.text = currentQuestion.text
        //Set the progress view to be the user's current progress
        questionProgressView.setProgress(totalProgress, animated: true)
        
        //Call the appropriate function depending on the current question's type
        switch currentQuestion.type {
           case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
            
        }
        
    }
        
        
        //Make the single Stack View visible
        //Set the button texts to the current question's answer options
        func updateSingleStack(using answers: [Answer]) {
            singleStackView.isHidden = false
            singleButton1.setTitle(answers[0].text, for: .normal)
            singleButton2.setTitle(answers[1].text, for: .normal)
            singleButton3.setTitle(answers[2].text, for: .normal)
            singleButton4.setTitle(answers[3].text, for: .normal)
        }
        
    
        //Make the multiple Stack View visible
        //Turn all switches off
        //Set the label texts to the current question's answer options
        func updateMultipleStack(using answers: [Answer]) {
            multipleStackView.isHidden = false
            multiSwitch1.isOn = false
            multiSwitch2.isOn = false
            multiSwitch3.isOn = false
            multiSwitch4.isOn = false
            multiLabel1.text = answers[0].text
            multiLabel2.text = answers[1].text
            multiLabel3.text = answers[2].text
            multiLabel4.text = answers[3].text
        }
    
        //Make the ranged Stack View visible
        //Set the slider value to be centered
        //Set the two labels to be the first and last answer options
        func updateRangedStack(using answers: [Answer]) {
            rangedStackView.isHidden = false
            rangedSlider.setValue(0.5, animated: false)
            rangedLabel1.text = answers.first?.text
            rangedLabel2.text = answers.last?.text
        }
      
    //Functions which append the user's selected answers to the answersChosen array
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    @IBAction func multipleAnswerButtonPressed() {
        
        if multiSwitch1.isOn{
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
        
    }
    
    
    //Function which increments the questionIndex by 1 and if there are any questions left,
    //call updateUI() to move on to the next question
    //If there are no questions left, performSegue is called so the ResultsViewController can be displayed
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "DiningResultsSegue", sender: nil)
        }
    }
    
    //Override the prepare function so that the user's current answers can be passed onto the ResultsViewController
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DiningResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
}

    
    
    

