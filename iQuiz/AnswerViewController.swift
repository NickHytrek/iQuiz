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
    var userAnswer : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionLabel.text = question
        correctAnswerLabel.text = correctAnswer
        if userAnswer == correctAnswer {
            resultLabel.text = "RIGHT!"
        }
        else {
            resultLabel.text = "WRONG!"
        }
    }
    


}
