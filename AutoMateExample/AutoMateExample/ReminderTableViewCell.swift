//
//  ReminderTableViewCell.swift
//  AutoMateExample
//
//  Created by Joanna Bednarz on 10/03/2017.
//  Copyright © 2017 PGS Software. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell, ConfigurableCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var completionDateLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!

    func configure(with model: ReminderViewModel) {
        titleLabel.text = model.title
        calendarLabel.text = model.calendar
        startDateLabel.text = model.startDateString
        completionDateLabel.text = model.completionDateString
        notesLabel.text = model.notes
    }
}
