//
//  ViewController.swift
//  iQuiz
//
//  Created by iGuest on 2/13/19.
//  Copyright © 2019 iGuest. All rights reserved.
//

import UIKit

class QuizDataSource : NSObject, UITableViewDataSource {
    
    var titles : [String] = []
    var subtitles : [String] = []
    init(_ elements : [String], _ otherElements : [String]) {
        titles = elements
        subtitles = otherElements
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        assert(section == 0)
        return "Quizzes"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>)
    }
    
    
}


class ViewController: UIViewController, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    let quizzesTitle = [ "Mathematics", "Marvel Super Heroes", "Science"]
    let quizzesSubtitle = [ "Can you even add 2 and 2?", "How well do you know Deadpool?",
                            "What chemicals can you mix to create explosions?!"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

