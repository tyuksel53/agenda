//
//  ViewController.swift
//  Agenda
//
//  Created by Taha Yüksel on 31.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progress: KYCircularProgress!
    @IBOutlet weak var inProgressChart: KYCircularProgress!
    @IBOutlet weak var toDoChart: KYCircularProgress!
    
    @IBOutlet weak var totalSummaryTotalTask: UILabel!
    
    @IBOutlet weak var totalSummaryDone: UILabel!
    @IBOutlet weak var totalSummaryToDo: UILabel!
    @IBOutlet weak var totalSummaryInProgess: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress.colors = [UIColor(red: 0.94, green: 0.60, blue: 0.36, alpha: 1.00)]
        progress.progress = 0.2
        
        inProgressChart.colors = [UIColor(red: 0.49, green: 0.85, blue: 0.51, alpha: 1.00)]
        inProgressChart.progress = 0.15
        
        
        toDoChart.colors = [UIColor(red: 0.46, green: 0.76, blue: 0.86, alpha: 1.00)]
        toDoChart.progress = 0.65
        
        
        totalSummaryTotalTask.attributedText = changeColorText(mainString: "Total Tasks: 5", stringToColor: "5")
        totalSummaryDone.attributedText = changeColorText(mainString: "Done: 1", stringToColor: "1")
        totalSummaryToDo.attributedText = changeColorText(mainString: "To Do: 1", stringToColor: "1")
        totalSummaryInProgess.attributedText = changeColorText(mainString: "In Progress: 3", stringToColor: "3")
     
    }
    
    func changeColorText(mainString: String, stringToColor: String) ->  NSMutableAttributedString {
        
        let range = (mainString as NSString).range(of: stringToColor)

        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        
        let color = UIColor(red: 0.94, green: 0.60, blue: 0.36, alpha: 1.00)
        
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        return mutableAttributedString
    }


}

