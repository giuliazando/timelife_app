//
//  CalendarVar.swift
//  Timelife
//
//  Created by Giulia Zandonà on 08/05/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current
let day = calendar.component(.day, from: date)
let weekend = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date)
var year = calendar.component(.year, from: date)


