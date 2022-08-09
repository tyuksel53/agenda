//
//  HistoryViewController.swift
//  Agenda
//
//  Created by Taha Yüksel on 8.08.2022.
//

import UIKit
import JTAppleCalendar

class HistoryViewController: UIViewController {

    @IBOutlet weak var calendar: JTACMonthView!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var taskListView: UITableView!
    
    var taskList = [Task(taskName: "Practice", workLog: 2), Task(taskName: "Learn English" , workLog: 3),
    Task(taskName: "Play Piano", workLog: 1), Task(taskName: "Read Book", workLog: 3), Task(taskName: "Watch Movie", workLog: 2), Task(taskName: "Take a Walk", workLog: 5)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.ibCalendarDelegate = self
        calendar.ibCalendarDataSource = self
        
        calendar.allowsMultipleSelection = false
        
        taskListView.delegate = self
        
        taskListView.dataSource = self
        
        taskListView.register(UINib(nibName: "TaskHistoryTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "historyCell")
        
        let today = Date()
        
        calendar.scrollToDate(today, animateScroll: false)
        
        calendar.visibleDates { visibleDates in
            self.setupMonthLabel(date: visibleDates.monthDates.first!.date)
        }
        
        
    }
    
    func setupMonthLabel(date: Date) {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en-US")
        df.dateFormat = "MMM yyyy"
        monthLabel.text = df.string(from: date)
    }
    
    func handleCellColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = .black
        } else {
            cell.dateLabel.textColor = .gray
        }
        
    }
    
    func handleConfiguration(cell: JTACDayCell?, cellState: CellState) {
        guard let cell = cell as? DateCell else { return }
        handleCellColor(cell: cell, cellState: cellState)
    }
    
    func handleCellSelection(cell: DateCell, cellState: CellState) {
        cell.selectedView.layer.cornerRadius = 5
        cell.selectedView.backgroundColor = UIColor(red: 0.49, green: 0.85, blue: 0.51, alpha: 1.00)
        
        cell.selectedView.clipsToBounds = true
    }
    
}

//MARK UITableViewDelegate, UITableViewDataSource

extension HistoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! TaskHistoryTableViewCell
        cell.taskName.text = taskList[indexPath.row].taskName
        cell.taskDesc.text = String(format: "%.2f hours", taskList[indexPath.row].workLog)
        cell.accessoryType = .checkmark
        return cell
    }
    
    
}

//MARK JTACMonthViewDelegate - JTACMonthViewDataSource

extension HistoryViewController : JTACMonthViewDelegate, JTACMonthViewDataSource {
    
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupMonthLabel(date: visibleDates.monthDates.first!.date)
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! DateCell
        cell.dateLabel.text = cellState.text
        handleConfiguration(cell: cell, cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        
        cell.dateLabel.text = cellState.text
        
        handleConfiguration(cell: cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        handleCellSelection(cell: cell as! DateCell, cellState: cellState)
    }
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd";
        
        let startDate = dateFormatter.date(from: "2022 01 01")!
        
        let currentDate = Date()
        
        var dateComponent = DateComponents()
        dateComponent.month = 6
        
        let endDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)!
        
        return ConfigurationParameters(startDate: startDate, endDate: endDate, firstDayOfWeek: .monday)
    }
    
}
