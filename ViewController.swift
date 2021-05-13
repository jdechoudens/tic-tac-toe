//
//  ViewController.swift
//  assignmentNotebookDeChoudens
//
//  Created by period4 on 4/5/21.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        

        return self.subjects.count    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectsCell")

        cell?.textLabel?.text = self.subjects[indexPath.row]

        cell?.backgroundColor = .lightGray

        cell?.textLabel?.textColor = .blue

        cell?.detailTextLabel?.text = self.assignments[indexPath.row]

        return cell!

    }

    

    var subjects = ["College Comp.", "AP Bio", "AB Calc", "AP Econ", "App Development"]

    var assignments = [""]

    @IBOutlet weak var anTableView: UITableViewCell!

    override func viewDidLoad() {

        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    

    func alert() {

        let alertController = UIAlertController(title: "Pick Your Subject", message: "What's due?", preferredStyle: .alert)

        

        let addAssignmentButton = UIAlertAction(title: "Done", style: .default) { (action) in

            alertController.addTextField{ (subject) in

            subject.placeholder = "enter Subject"

            alertController.addTextField { (Assignment) in

            

            Assignment.text = "enter assignment"

            self.assignments.append(Assignment.text!)

            self.subjects.append(subject.text!)

            self.anTableView.reloadData()

                    }

            }

                

            }

        alertController.addAction(addAssignmentButton)

        present(alertController, animated: true, completion: nil)

        

        }



    
    @IBAction func addAssignment(_ sender: Any) {

        alert()

    

    }

    

}



