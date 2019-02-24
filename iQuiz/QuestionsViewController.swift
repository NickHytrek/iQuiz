//
//  QuestionsViewController.swift
//  iQuiz
//
//  Created by iGuest on 2/21/19.
//  Copyright © 2019 iGuest. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonAnswerOne: UIButton!
    @IBOutlet weak var buttonAnswerTwo: UIButton!
    @IBOutlet weak var buttonAnswerThree: UIButton!
    @IBOutlet weak var buttonAnswerFour: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    var currentQuiz : String? = ""
    let mathQuestions : [String] = ["What is 2 + 2?"]
    let mathAnswers : [String] = ["1", "2", "3", "4"]
    let correctMathAnswers : [String] = ["4"]
    let marvelQuestions : [String] = ["Who plays Deadpool in the movie?"]
    let marvelAnswers : [String] = ["Josh Reynolds", "Roger Rynold", "Robin Williams", "Ryan Reynolds"]
    let correctMarvelAnswers : [String] = ["4"]
    let scienceQuestions : [String] = ["What is the first element of the periodic table?"]
    let scienceAnswers : [String] = ["Boron", "Hydrogen", "Helium", "Calcium"]
    let correctScienceAnswers : [String] = ["2"]
    var selectedAnswer : String = ""
    var total : [Int] = [0, 0]
    var questionCount = 0
    var segueIdentifier : String = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        submitButton.isEnabled = false
        if currentQuiz == "Math" {
            total[1] = mathQuestions.count
            questionLabel.text = mathQuestions[0]
            buttonAnswerOne.setTitle(mathAnswers[0], for: UIControl.State.normal)
            buttonAnswerTwo.setTitle(mathAnswers[1], for: UIControl.State.normal)
            buttonAnswerThree.setTitle(mathAnswers[2], for: UIControl.State.normal)
            buttonAnswerFour.setTitle(mathAnswers[3], for: UIControl.State.normal)
        }
        else if currentQuiz == "Marvel Super Heroes" {
            total[1] = marvelQuestions.count
            questionLabel.text = marvelQuestions[0]
            buttonAnswerOne.setTitle(marvelAnswers[0], for: UIControl.State.normal)
            buttonAnswerTwo.setTitle(marvelAnswers[1], for: UIControl.State.normal)
            buttonAnswerThree.setTitle(marvelAnswers[2], for: UIControl.State.normal)
            buttonAnswerFour.setTitle(marvelAnswers[3], for: UIControl.State.normal)
        }
        else if currentQuiz == "Science" {
            total[1] = marvelQuestions.count
            questionLabel.text = scienceQuestions[0]
            buttonAnswerOne.setTitle(scienceAnswers[0], for: UIControl.State.normal)
            buttonAnswerTwo.setTitle(scienceAnswers[1], for: UIControl.State.normal)
            buttonAnswerThree.setTitle(scienceAnswers[2], for: UIControl.State.normal)
            buttonAnswerFour.setTitle(scienceAnswers[3], for: UIControl.State.normal)
        }
    }
    
    @IBAction func touchupAnswerOne(_ sender: UIButton) {
        selectedAnswer = "1"
        sender.backgroundColor = UIColor.lightGray
        buttonAnswerTwo.backgroundColor = UIColor.white
        buttonAnswerThree.backgroundColor = UIColor.white
        buttonAnswerFour.backgroundColor = UIColor.white
        if submitButton.isEnabled == false {
            submitButton.isEnabled = true
        }
    }
    
    @IBAction func touchupAnswerTwo(_ sender: UIButton) {
        selectedAnswer = "2"
        sender.backgroundColor = UIColor.lightGray
        buttonAnswerOne.backgroundColor = UIColor.white
        buttonAnswerThree.backgroundColor = UIColor.white
        buttonAnswerFour.backgroundColor = UIColor.white
        if submitButton.isEnabled == false {
            submitButton.isEnabled = true
        }
    }
    
    @IBAction func touchupAnswerThree(_ sender: UIButton) {
        selectedAnswer = "3"
        sender.backgroundColor = UIColor.lightGray
        buttonAnswerOne.backgroundColor = UIColor.white
        buttonAnswerTwo.backgroundColor = UIColor.white
        buttonAnswerFour.backgroundColor = UIColor.white
        if submitButton.isEnabled == false {
            submitButton.isEnabled = true
        }
    }
    
    @IBAction func touchupAnswerFour(_ sender: UIButton) {
        selectedAnswer = "4"
        sender.backgroundColor = UIColor.lightGray
        buttonAnswerOne.backgroundColor = UIColor.white
        buttonAnswerTwo.backgroundColor = UIColor.white
        buttonAnswerThree.backgroundColor = UIColor.white
        if submitButton.isEnabled == false {
            submitButton.isEnabled = true
        }
    }
    @IBAction func touchupBackHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToHome", sender: self)
        segueIdentifier = "backToHome"
    }
    
    @IBAction func touchupSubmitAnswer(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAnswer", sender: self)
        segueIdentifier = "goToAnswer"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToAnswer" else {return}
        let answer = segue.destination as! AnswerViewController
        if currentQuiz == "Math" {
            answer.correctAnswer = mathAnswers[Int(correctMathAnswers[0])! - 1]
            answer.question = mathQuestions[0]
            if selectedAnswer == correctMathAnswers[0] {
                answer.correct = true
            }
            else {
                answer.correct = false
            }
        }
        else if currentQuiz == "Marvel Super Heroes" {
            answer.correctAnswer = marvelAnswers[Int(correctMarvelAnswers[0])! - 1]
            answer.question = marvelQuestions[0]
            if selectedAnswer == correctMarvelAnswers[0] {
                answer.correct = true
            }
            else {
                answer.correct = false
            }
        }
        else if currentQuiz == "Science" {
            answer.correctAnswer = scienceAnswers[Int(correctScienceAnswers[0])! - 1]
            answer.question = scienceQuestions[0]
            if selectedAnswer == correctScienceAnswers[0] {
                answer.correct = true
            }
            else {
                answer.correct = false
            }
        }
        answer.total = total
        answer.questionCount = questionCount
    }
 
}
