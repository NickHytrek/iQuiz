//
//  ViewController.swift
//  iQuiz
//
//  Created by iGuest on 2/13/19.
//  Copyright © 2019 iGuest. All rights reserved.
//

import UIKit

// structures for ease of decoding JSON
struct Quiz: Codable {
    let title: String
    let desc: String
    let questions: [Questions]
}

struct Questions: Codable {
    let text: String
    let answer: String
    let answers: [String]
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var popoverView: UIView!
    @IBOutlet weak var urlTextField: UITextField!
    let quizImages : [UIImage] = [UIImage(named: "science")!, UIImage(named: "hero")!, UIImage(named: "math")!]
    var quizToGoTo : Int = -1
    var url = URL(string: "http://tednewardsandbox.site44.com/questions.json")
    let fileId = UUID()
    var jsonQuiz = [Quiz]()
    let network : NetworkManager = NetworkManager.sharedInstance
    
    //************************************* TableView Functions *************************************//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonQuiz.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath)
        myCell.textLabel?.text = jsonQuiz[indexPath.row].title
        myCell.detailTextLabel?.text = jsonQuiz[indexPath.row].desc
        myCell.imageView?.image = quizImages[indexPath.row]
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        quizToGoTo = indexPath.row
        self.performSegue(withIdentifier: "quizQuestions", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quiz = segue.destination as! QuestionsViewController
        //TODO Send over necessary data here
        quiz.questions = jsonQuiz[quizToGoTo].questions
    }
    //**************************************************************************//

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.popoverView.layer.cornerRadius = 10
        downloadQuiz()
        configureTextField()
        NetworkManager.isUnreachable { _ in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Offline", message: "No Internet Connection", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                //print("Loading from local storage", self.loadJSON())
                self.jsonQuiz = self.loadJSON()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func toolBarSettings(_ sender: UIBarButtonItem) {
        self.view.addSubview(popoverView)
        popoverView.center = self.view.center
    }
    
    @IBAction func popoverDone(_ sender: UIButton) {
        self.popoverView.removeFromSuperview()
    }
    
    @IBAction func checkForQuizDownload(_ sender: UIButton) {
        let newUrl = URL(string: urlTextField.text!)
        url = newUrl
        downloadQuiz()
    }
    
//************************************* Custom Functions *************************************//
    func downloadQuiz () {
        guard let downloadURL = url else {return}
        URLSession.shared.dataTask(with: downloadURL) { (data, urlResponse, error) in
            guard error == nil && data != nil && urlResponse != nil else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Something Went Wrong With the Download :(", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                return
            }
            do {
                self.saveJSON(data!)
                let quizzes = try JSONDecoder().decode([Quiz].self, from: data!)
                self.jsonQuiz = quizzes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            catch {
                fatalError("Data is no good")
            }
            
            }.resume()
    }
    
    func saveJSON(_ data: Data) {
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: "SavedQuizzes")
        defaults.synchronize()
    }
    
    func loadJSON() -> [Quiz] {
        var quizzes = [Quiz]()
        if let savedQuizzes = UserDefaults.standard.object(forKey: "SavedQuizzes") as? Data {
            let decoder = JSONDecoder()
            if let loadedQuizzes = try? decoder.decode([Quiz].self, from: savedQuizzes) {
                quizzes = loadedQuizzes
            }
        }
        else {
            quizzes = jsonQuiz
        }
        return quizzes
    }

    private func configureTextField() {
        urlTextField.delegate = self as? UITextFieldDelegate
    }
    
    //**************************************************************************//
}

