//
//  File.swift
//  ADS103_Quiz Project
//
//  Created by Amina on 30/4/18.
//  Copyright © 2018 Amina. All rights reserved.
//

import Foundation

//Question struct so there is a standard way of accessing questions in the app
struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}


//Enum of all different response types in the app
enum ResponseType {
    case single, multiple, ranged
}

//Answer struct so there is an easy way of accessing and recording answers
struct Answer {
    var text: String
    var type: ResultType
}

//Enum of all possible results in the whole app
enum ResultType {
    case Andaz, Trevi, Enigma, Eaton, RHTC, CastleTowers, HomeHub, Norwest, Movies, MiniGolf, Forest, Library
    
    var definition: String {
        switch self {
        case .Andaz:
            return "Andaz Indian, Castle Hill"
        case .Trevi:
            return "Trevi Lakeside Restaurant, Bella Vista"
        case .Enigma:
            return "Enigma at the Piazza, Castle Towers"
        case .Eaton:
            return "Eaton Gardens Chinese Restaurant, Kellyville"
        case .CastleTowers:
            return "Castle Towers: a shopping centre with a wide range of affordable shops"
        case .HomeHub:
            return "Home Hub, Castle Hill: a two building shopping complex for all your home, electrical and garden needs"
        case .RHTC:
            return "Rouse Hill Town Centre: an outdoor shopping complex, with a large variety of stores and restaurants"
        case .Norwest:
            return "Norwest Marketown: a single floor shopping village for all your daily needs"
        case .Movies:
            return "Event Cinemas, Castle Towers"
        case .MiniGolf:
            return "Holey Moley Mini Golf + Strike Bowling, Castle Towers"
        case .Forest:
            return "Cumberland State Forest, West Pennant Hills"
        case .Library:
            return "Castle Hill Library"
       }
    }
}


//Array storing the Dining quiz questions
var diningQuestions: [Question] = [
    Question(text: "What types of food do you like?", type: .multiple, answers: [Answer(text: "Asian", type: .Eaton), Answer(text: "Indian", type: .Andaz), Answer(text: "Italian", type: .Trevi), Answer(text: "Mediterranean", type: .Enigma)]),
    Question(text: "How important is restaurant atmosphere to you?", type: .ranged, answers: [Answer(text: "Not at all", type: .Andaz), Answer(text: "A bit", type: .Eaton), Answer(text: "Somewhat", type: .Enigma), Answer(text: "Very important", type: .Trevi)]),
    Question(text: "Any dietary preferences?", type: .multiple, answers: [Answer(text: "Vegan", type: .Eaton), Answer(text: "Vegetarian", type: .Andaz), Answer(text: "Gluten-Free", type: .Enigma), Answer(text: "Dairy-Free", type: .Trevi)]),
    Question(text: "What's your favourite part of a meal?", type: .single, answers: [Answer(text: "Drinks", type: .Enigma), Answer(text: "Dessert", type: .Trevi), Answer(text: "Soup", type: .Eaton), Answer(text: "Entree", type: .Andaz)])
]


//Array storing the Shopping Quiz questions
var shoppingQuestions: [Question] = [
    Question(text: "Why are you going to the shops today?", type: .single, answers: [Answer(text: "Retail therapy", type: .CastleTowers), Answer(text: "Running errands", type: .Norwest), Answer(text: "For coffee or a meal", type: .RHTC), Answer(text: "Shopping for homewares/appliances", type: .HomeHub)]),
    Question(text: "Which type of shops interest you?", type: .multiple, answers: [Answer(text: "Clothes and accessories", type: .CastleTowers), Answer(text: "Home/garden furniture & appliances", type: .HomeHub), Answer(text: "Restaurants/Cafes/Fast-food", type: .RHTC), Answer(text: "Grocery Stores/Services", type: .Norwest)]),
    Question(text: "Which area are you closest to?", type: .ranged, answers: [Answer(text: "Norwest", type: .Norwest), Answer(text: "Rouse Hill", type: .RHTC), Answer(text: "Kellyville", type: .HomeHub), Answer(text: "Castle Hill", type: .CastleTowers)]),
    Question(text: "You need a shopping centre where: ", type: .single, answers: [Answer(text: "There's a nice atmosphere", type: .RHTC), Answer(text: "There's a wide range of shops", type: .CastleTowers), Answer(text: "You can do your everyday errands", type: .Norwest), Answer(text: "There's access to public transport", type: .HomeHub)])
]


//Array storing the Entertainment quiz questions
var entertainmentQuestions: [Question] = [
    Question(text: "How many people are in your group?", type: .single, answers: [Answer(text: "1", type: .Library), Answer(text: "2", type: .Forest), Answer(text: "3", type: .Movies), Answer(text: "4+", type: .MiniGolf)]),
    Question(text: "Pick one: ", type: .single, answers: [Answer(text: "Liveliness", type: .MiniGolf), Answer(text: "Tranquility", type: .Forest), Answer(text: "Calmness", type: .Library), Answer(text: "Simplicity", type: .Movies)]),
    Question(text: "What's your level of noise tolerance today?", type: .ranged, answers: [Answer(text: "Very low", type: .Library), Answer(text: "Low", type: .Forest), Answer(text: "Loud", type: .MiniGolf), Answer(text: "Very loud", type: .Movies)]),
    Question(text: "What's your energy level today?", type: .ranged, answers: [Answer(text: "Very low", type: .Library), Answer(text: "Medium", type: .Movies), Answer(text: "High", type: .Forest), Answer(text: "Very high", type: .MiniGolf)])
    
]





//Function to shuffle questions
func shuffle(questionArray:[Question]) -> [Question] {
    
    //create a copy of the input array
    var questions = questionArray
    
    //our new shuffled array
    var shuffled = [Question]();
    
    //iterate through the item array
    for _ in questions.enumerated()
    {
        //choose a random number
        let rand = Int(arc4random_uniform(UInt32(questions.count)))
        //using that random number, select a random item
        let randomQuestion = questions[rand]
        //append that random item to our new shuffled array
        shuffled.append(randomQuestion)
        //make sure to remove that item, so we don't pick it again
        questions.remove(at: rand)
    }
    return shuffled
}


//Function to shuffle answers
func shuffleAnswers(answerArray:[Answer]) -> [Answer] {
    
    //create a copy of the input array
    var answers = answerArray
    
    //our new shuffled array
    var shuffled = [Answer]();
    
    //iterate through the item array
    for _ in answers.enumerated()
    {
        //choose a random number
        let rand = Int(arc4random_uniform(UInt32(answers.count)))
        //using that random number, select a random item
        let randomAnswer = answers[rand]
        //append that random item to our new shuffled array
        shuffled.append(randomAnswer)
        //make sure to remove that item, so we don't pick it again
        answers.remove(at: rand)
    }
    return shuffled
}
