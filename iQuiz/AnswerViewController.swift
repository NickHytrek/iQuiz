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
    //var userAnswer : String = ""
    var total : [Int] = [0, 0]
    var questionCount : Int = 0
    var correct : Bool = false
    

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
            self.performSegue(withIdentifier: "goToFinish" , sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let finish = segue.destination as! FinishViewController
        finish.total = total
    }
    

}
