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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.visibleDates { visibleDates in
            self.setupMonthLabel(date: visibleDates.monthDates.first!.date)
        }
        
        
    }
    
    func setupMonthLabel(date: Date) {
        let df = DateFormatter()
        df.dateFormat = "yyyy MMM"
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
        //handleCellSelection(cell: cell, cellState: cellState)
    }
    
}

//MARK JTACMonthViewDataSource

extension HistoryViewController : JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd";
        
        let startDate = dateFormatter.date(from: "2022 01 01")!
        let endDate = Date()
        
        return ConfigurationParameters(startDate: startDate, endDate: endDate,
                                       generateInDates: .off, generateOutDates: .off, firstDayOfWeek: .monday)
    }
    
}

//MARK JTACMonthViewDelegate

extension HistoryViewController : JTACMonthViewDelegate {
    
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
    
    
}
