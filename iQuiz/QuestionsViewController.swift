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
    var currentQuiz : String? = ""
    let mathQuestions : [String] = ["What is 2 + 2?"]
    let mathAnswers : [String] = ["1", "2", "3", "4"]
    let correctMathAnswers : [String] = ["4"]
    var selectedAnswer : String = ""
    var total : [Int] = [0, 0]
    var questionCount = 0
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if currentQuiz == "Math" {
            total[1] = mathQuestions.count
            questionLabel.text = mathQuestions[0]
            buttonAnswerOne.setTitle(mathAnswers[0], for: UIControl.State.normal)
            buttonAnswerTwo.setTitle(mathAnswers[1], for: UIControl.State.normal)
            buttonAnswerThree.setTitle(mathAnswers[2], for: UIControl.State.normal)
            buttonAnswerFour.setTitle(mathAnswers[3], for: UIControl.State.normal)
        }
    }
    
    @IBAction func touchupAnswerOne(_ sender: UIButton) {
        selectedAnswer = sender.titleLabel!.text!
        sender.backgroundColor = UIColor.lightGray
        buttonAnswerTwo.backgroundColor = UIColor.white
        buttonAnswerThree.backgroundColor = UIColor.white
        buttonAnswerFour.backgroundColor = UIColor.white
    }
    
    @IBAction func touchupAnswerTwo(_ sender: UIButton) {
        selectedAnswer = sender.titleLabel!.text!
        sender.backgroundColor = UIColor.lightGray
        buttonAnswerOne.backgroundColor = UIColor.white
        buttonAnswerThree.backgroundColor = UIColor.white
        buttonAnswerFour.backgroundColor = UIColor.white
    }
    
    @IBAction func touchupAnswerThree(_ sender: UIButton) {
        selectedAnswer = sender.titleLabel!.text!
        sender.backgroundColor = UIColor.lightGray
        buttonAnswerOne.backgroundColor = UIColor.white
        buttonAnswerTwo.backgroundColor = UIColor.white
        buttonAnswerFour.backgroundColor = UIColor.white
    }
    
    @IBAction func touchupAnswerFour(_ sender: UIButton) {
        selectedAnswer = sender.titleLabel!.text!
        sender.backgroundColor = UIColor.lightGray
        buttonAnswerOne.backgroundColor = UIColor.white
        buttonAnswerTwo.backgroundColor = UIColor.white
        buttonAnswerThree.backgroundColor = UIColor.white
    }
    
    @IBAction func touchupSubmitAnswer(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAnswer", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let answer = segue.destination as! AnswerViewController
        answer.correctAnswer = correctMathAnswers[0]
        answer.question = mathQuestions[0]
        answer.userAnswer = selectedAnswer
        answer.total = total
        answer.questionCount = questionCount
    }
}
