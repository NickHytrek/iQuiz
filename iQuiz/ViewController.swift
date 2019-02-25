//
//  ViewController.swift
//  iQuiz
//
//  Created by iGuest on 2/13/19.
//  Copyright © 2019 iGuest. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var quizToGoTo : String = ""
    
    let quizTitle : [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    let quizSubtitle: [String] = ["Can you even add 2 and 2?", "How well do you know Deadpool?", "What chemicals mix to create explosions?!"]
    let quizImages : [UIImage] = [UIImage(named: "math")!, UIImage(named: "hero")!, UIImage(named: "science")!]
    @IBOutlet var popoverView: UIView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath)
        myCell.textLabel?.text = quizTitle[indexPath.row]
        myCell.detailTextLabel?.text = quizSubtitle[indexPath.row]
        myCell.imageView?.image = quizImages[indexPath.row]
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            quizToGoTo = "Math"
        }
        else if indexPath.row == 1 {
            quizToGoTo = "Marvel Super Heroes"
        }
        else {
            quizToGoTo = "Science"
        }
        
        self.performSegue(withIdentifier: "quizQuestions", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quiz = segue.destination as! QuestionsViewController
        quiz.currentQuiz = quizToGoTo
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.popoverView.layer.cornerRadius = 10
    }

    @IBAction func toolBarSettings(_ sender: UIBarButtonItem) {
        self.view.addSubview(popoverView)
        popoverView.center = self.view.center
    }
    
    @IBAction func popoverDone(_ sender: UIButton) {
        self.popoverView.removeFromSuperview()
    }
}

