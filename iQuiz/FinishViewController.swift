//
//  FinishViewController.swift
//  iQuiz
//
//  Created by iGuest on 2/22/19.
//  Copyright © 2019 iGuest. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var total : [Int] = [0, 0]
    var answered : String = ""
    var possible : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.]
        answered = String(total[0])
        possible = String(total[1])
        if total[0] == total[1] {
            finishLabel.text = "WOW!"
            
        }
        else if total[0] == 0 {
            finishLabel.text = "You Suck!"
        }
        else {
            finishLabel.text = "Nice!"
        }
        scoreLabel.text = answered + "/" + possible
    }
    
    @IBAction func touchUpHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goHome", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let home = segue.destination as! ViewController
    }

}
