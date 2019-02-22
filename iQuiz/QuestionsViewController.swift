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
    var currentQuiz : String? = ""
    let mathQuestions : [String] = ["What is 2 + 2?"]
    let mathAnswers : [String] = ["1", "2", "3", "4"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if currentQuiz == "Math" {
            questionLabel.text = mathQuestions[0]
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
