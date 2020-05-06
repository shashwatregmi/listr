//
//  Meal.swift
//  listr
//
//  Created by Regmi on 2020-05-06.
//  Copyright © 2020 Regmi. All rights reserved.
//

import UIKit

class Task{
    
    var name:String
    var priority:Int
    var img:UIImage? // Makes this a optional?
    
    init?(name: String, img: UIImage?, priority: Int) { //Like Constructor
        self.name = name
        self.img = img
        self.priority = priority
        if name.isEmpty || priority < 0  {
            return nil
        }
    }
}
