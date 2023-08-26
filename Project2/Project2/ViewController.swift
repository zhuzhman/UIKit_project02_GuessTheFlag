//
//  ViewController.swift
//  Project2
//
//  Created by Mikhail Zhuzhman on 25.08.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .bookmarks,
            image: UIImage(systemName: "person.fill.questionmark"),
            style: .plain,
            target: self,
            action: #selector(scoreTapped)
        )
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
//        title = "Your score is: \(score)    |  Please choose " + title!
        title = "Please choose " + title!
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        questionsCount += 1
        
        if questionsCount == 3 {
            var ac = UIAlertController()
            if title == "Wrong" {
                ac = UIAlertController(title: "Game over", message: "Your final score is \(score). This is flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            } else {
                ac = UIAlertController(title: "Game over", message: "Your final score is \(score).", preferredStyle: .alert)
            }
            ac.addAction(UIAlertAction(title: "That's it! Try again!", style: .destructive, handler: askQuestion))
            present(ac, animated: true)
            score = 0
            questionsCount = 0
        } else {
            var ac = UIAlertController()
            if title == "Wrong" {
                ac = UIAlertController(title: title, message: "Your score is \(score). This is flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            } else {
                ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            }
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    
    @objc func scoreTapped() {
        var ac = UIAlertController()
        ac = UIAlertController(title: "Your Score", message: "Your actual score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

extension UIBarButtonItem.SystemItem {
    func image() -> UIImage? {
        let tempItem = UIBarButtonItem(barButtonSystemItem: self,
                                       target: nil,
                                       action: nil)

        let bar = UIToolbar()
        bar.setItems([tempItem],
                     animated: false)
        bar.snapshotView(afterScreenUpdates: true)

        // imageを取得する
        let itemView = tempItem.value(forKey: "view") as! UIView
        for view in itemView.subviews {
            if let button = view as? UIButton,
                let image = button.imageView?.image {
                return image.withRenderingMode(.alwaysTemplate)
            }
        }
        return nil
    }
}
