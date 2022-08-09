//
//  TaskHistoryTableViewCell.swift
//  Agenda
//
//  Created by Taha Yüksel on 9.08.2022.
//

import UIKit

class TaskHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var taskName: UILabel!
    
    @IBOutlet weak var taskDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
