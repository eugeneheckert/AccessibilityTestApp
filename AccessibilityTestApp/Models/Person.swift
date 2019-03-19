//
//  People.swift
//  AccessibilityTestApp
//
//  Created by Eugene Heckert on 2/21/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    //MARK: Variables
    let name: String
    let birthday: Date
    
    override var description: String {
        return "\nname: \(name), birthday: \(birthday)"
    }
    
    override init() {
        name = "\(Person.firstName()) \(Person.lastName())"
        birthday = Person.birthday()
        super.init()
    }
    
    static func generatePersonList(count: Int) -> [Person] {
        var personList: [Person] = []
        
        for _ in 0...count {
            personList.append(Person.init())
        }
        return personList
    }
    
    
    //MARK: Private class Methods
    private static func firstName() -> String {
        let firstNameList = Person.fetchFirstNameJSON()
        let randomIndex = arc4random_uniform(UInt32(firstNameList.count - 1))
        
        return firstNameList[Int(randomIndex)]
    }
    
    private static func lastName() -> String {
        let lastNameList = Person.fetchLastNameJSON()
        let randomIndex = arc4random_uniform(UInt32(lastNameList.count - 1))
        
        return lastNameList[Int(randomIndex)]
    }
    
    private static func birthday() -> Date {
        let day = arc4random_uniform(UInt32(356))
        let year = arc4random_uniform(UInt32(100))
        
        let currentYear = Calendar.current.component(Calendar.Component.year, from: Date())
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        
        dateComponents.day = Int(day)
        dateComponents.year = currentYear - Int(year)
        
        let randomDate = calendar.date(from: dateComponents)
        
        return randomDate ?? Date()
    }
    
    private static func fetchFirstNameJSON() -> [String] {
        if let filePath = Bundle.main.url(forResource: "first_names", withExtension: ".json") {
            
            do {
                let jsonData = try Data(contentsOf: filePath)
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String : [String]]
                return json["names"] ?? []
            } catch let error as NSError {
                print("Error fetching JSON: \(error)")
                return []
            }
        }
        
        return []
    }
    
    private static func fetchLastNameJSON() -> [String] {
        if let filePath = Bundle.main.url(forResource: "last_names", withExtension: ".json") {
            
            do {
                let jsonData = try Data(contentsOf: filePath)
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String : [String]]
                return json["names"] ?? []
            } catch let error as NSError {
                print("Error fetching JSON: \(error)")
                return []
            }
        }
        
        return []
    }

}
