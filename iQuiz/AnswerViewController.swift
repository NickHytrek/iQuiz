//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by iGuest on 2/22/19.
//  Copyright © 2019 iGuest. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var question : String = ""
    var correctAnswer : String = ""
    var total : [Int] = [0, 0]
    var questionCount : Int = 0
    var correct : Bool = false
    var segueIdentifier : String = ""
    var currentQuiz : [Questions] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionLabel.text = question
        correctAnswerLabel.text = correctAnswer
        questionCount = questionCount + 1
        if correct {
            resultLabel.text = "RIGHT!"
            total[0] = total[0] + 1
        }
        else {
            resultLabel.text = "WRONG!"
        }
    }
    
    @IBAction func touchupGoNext(_ sender: UIButton) {
        if questionCount == total[1] {
            segueIdentifier = "goToFinish"
            self.performSegue(withIdentifier: "goToFinish" , sender: nil)
        }
        else {
            segueIdentifier = "goToNextQuestion"
            self.performSegue(withIdentifier: "goToNextQuestion", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segueIdentifier == "goToFinish" {
            let finish = segue.destination as! FinishViewController
            finish.total = total
        }
        else if segueIdentifier == "goToNextQuestion" {
            let nextQuestion = segue.destination as! QuestionsViewController
            nextQuestion.questionCount = questionCount
            nextQuestion.total = total
            nextQuestion.questions = currentQuiz
        }
    }
    

}
