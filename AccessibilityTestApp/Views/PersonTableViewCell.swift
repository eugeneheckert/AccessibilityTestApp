//
//  PeopleTableViewCell.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 2/21/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    //MARK: Variables
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    
    static var reuseIdentifier: String {
        return "PersonTableViewCell"
    }
    
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Public Function
    func configure(with person: Person) {
        nameLabel.text = person.name
        birthdayLabel.text = person.birthday.birthdayString()
    }

}

extension Date {
    func birthdayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
}
