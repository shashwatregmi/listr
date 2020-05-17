//
//  Task.swift
//  listr
//
//  Created by Regmi on 2020-05-06.
//  Copyright © 2020 Regmi. All rights reserved.
//

import UIKit
import os.log

class Task: NSObject, NSCoding{
    
    var name:String
    var priority:Int
    var img:UIImage? // Makes this a optional?
    
    //MARK: Archiving Paths
     
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tasks")
    
    struct propertyKey{
        static let name = "name"
        static let priority = "priority"
        static let photo = "img"
    }
    
    init?(name: String, img: UIImage?, priority: Int) { //Like Constructor
        self.name = name
        self.img = img
        self.priority = priority
        if name.isEmpty || priority > 5 || priority < 0 {
            return nil
        }
    }
    
    //  NsCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: propertyKey.name)
        aCoder.encode(img, forKey: propertyKey.photo)
        aCoder.encode(priority, forKey: propertyKey.priority)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: propertyKey.name) as? String else {
            os_log("Unable to decode the name for the Task.", log: OSLog.default, type: .debug)
            return nil
        }
        let priority = aDecoder.decodeInteger(forKey: propertyKey.priority)
        let photo = aDecoder.decodeObject(forKey: propertyKey.photo) as? UIImage

        self.init(name: name, img: photo, priority: priority)
    }
}
