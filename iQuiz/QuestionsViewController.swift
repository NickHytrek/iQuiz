//
//  QuestionsViewController.swift
//  iQuiz
//
//  Created by iGuest on 2/21/19.
//  Copyright © 2019 iGuest. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    // Artifacts of part 2
    //    var currentQuiz : String? = ""
    //    let mathQuestions : [String] = ["What is 2 + 2?", "What is 4 + 4?"]
    //    let mathAnswers : [[String]] = [["1", "2", "3", "4"], ["8", "7", "6", "5"]]
    //    let correctMathAnswers : [String] = ["4","1"]
    //    let marvelQuestions : [String] = ["Who plays Deadpool in the movie?"]
    //    let marvelAnswers : [[String]] = [["Josh Reynolds", "Roger Rynold", "Robin Williams", "Ryan Reynolds"]]
    //    let correctMarvelAnswers : [String] = ["4"]
    //    let scienceQuestions : [String] = ["What is the first element of the periodic table?"]
    //    let scienceAnswers : [[String]] = [["Boron", "Hydrogen", "Helium", "Calcium"]]
    //    let correctScienceAnswers : [String] = ["2"]
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonAnswerOne: UIButton!
    @IBOutlet weak var buttonAnswerTwo: UIButton!
    @IBOutlet weak var buttonAnswerThree: UIButton!
    @IBOutlet weak var buttonAnswerFour: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    var selectedAnswer : String = ""
    var total : [Int] = [0, 0]
    var questionCount = 0
    var segueIdentifier : String = ""
    var questions : [Questions] = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        submitButton.isEnabled = false
        total[1] = questions.count
        questionLabel.text = questions[questionCount].text
        buttonAnswerOne.setTitle(questions[questionCount].answers[0], for: .normal)
        buttonAnswerTwo.setTitle(questions[questionCount].answers[1], for: .normal)
        buttonAnswerThree.setTitle(questions[questionCount].answers[2], for: .normal)
        buttonAnswerFour.setTitle(questions[questionCount].answers[3], for: .normal)
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
        let correctAnswerIndex = Int(questions[questionCount].answer)
        answer.correctAnswer = questions[questionCount].answers[correctAnswerIndex! - 1]
        answer.question = questions[questionCount].text
        if selectedAnswer == questions[questionCount].answer {
            answer.correct = true
        }
        else {
            answer.correct = false
        }
        answer.total = total
        answer.questionCount = questionCount
        answer.currentQuiz = questions
    }
 
}
