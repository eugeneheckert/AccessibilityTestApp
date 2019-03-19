//
//  DirectoryTableViewController.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 2/20/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class DirectoryTableViewController: UITableViewController {
    
    let personList: [Person] = {
        return Person.generatePersonList(count: 30)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier, for: indexPath) as? PersonTableViewCell else {
            return UITableViewCell()
        }
        
        let person = personList[indexPath.row]

        cell.configure(with: person)

        return cell
    }
}
