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

public class DataManager {
    
    static fileprivate func getDocumentDirectory() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        }
        else {
            fatalError("Unable to access document directory")
        }
    }
    // save a file
    static func save <T:Encodable> (_ object: T, with fileName: String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        print("This is the url path", url.path)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                print("removing file from given url")
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
            print("Does the file exist?", FileManager.default.fileExists(atPath: url.path), url.path)
            let newQuiz = load(fileName, with: Quiz.self)
            print(newQuiz)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    //load a file
    static func load <T:Decodable> (_ fileName: String, with type:T.Type) -> T {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        print(url.path)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        else {
            fatalError("Data unavailable at the specified path \(url.path)")
        }
    }
    //load all files
    /*
    static func loadAll <T:Decodable> (_ type:T.Type) -> [T] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            var modelObjects = [T]()
            for fileName in files {
                modelObjects.append(load(fileName, with: type))
            }
            return modelObjects
        } catch {
            fatalError("Could not load any files")
        }
    }*/
    
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var popoverView: UIView!
    var quizToGoTo : String = ""
    //TODO: fill these out with the downloaded data from the JSON
    let quizTitle : [String] = []
    let quizSubtitle: [String] = []
    let quizImages : [UIImage] = [UIImage(named: "science")!, UIImage(named: "hero")!, UIImage(named: "math")!]
    let url = URL(string: "http://tednewardsandbox.site44.com/questions.json")
    let fileId = UUID()
    
    //************************************* TableView Functions *************************************//
    
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
        
        self.performSegue(withIdentifier: self.fileId.uuidString, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quiz = segue.destination as! QuestionsViewController
        quiz.currentQuiz = quizToGoTo
    }
    
    //**************************************************************************//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.popoverView.layer.cornerRadius = 10
        downloadQuiz()
        print(fileId.uuidString)
        // TODO Figure out how to load file cause it's being saved it seems but always errors out when loaded.
    }

    func downloadQuiz () {
        guard let downloadURL = url else {return}
        URLSession.shared.dataTask(with: downloadURL) { (data, urlResponse, error) in
            guard error == nil else {
                print("error = \(error!)")
                return
            }
            guard data != nil else {
                print("no data")
                return
            }
            guard urlResponse != nil else {
                print("something is wrong with the response")
                return
            }
            do {
                let quizzes = try JSONDecoder().decode([Quiz].self, from: data!)
                print(quizzes)
                DataManager.save(quizzes, with: self.fileId.uuidString)
                print("does file exist?", FileManager.default.fileExists(atPath: self.fileId.uuidString), self.fileId.uuidString)
            }
            catch let JSONerr{
                print("error serializing json", JSONerr)
            }
            
            }.resume()
    }
    
    
    
    
    
    @IBAction func toolBarSettings(_ sender: UIBarButtonItem) {
        self.view.addSubview(popoverView)
        popoverView.center = self.view.center
    }
    
    @IBAction func popoverDone(_ sender: UIButton) {
        self.popoverView.removeFromSuperview()
    }
    

}

