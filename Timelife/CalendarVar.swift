//
//  CalendarVar.swift
//  Timelife
//
//  Created by Giulia Zandonà on 08/05/18.
//  Copyright © 2018 Giulia Zandonà. All rights reserved.
//

import Foundation

let date = Date()
let calendario = Calendar.current
let day = calendario.component(.day, from: date)
let weekday = calendario.component(.weekday, from: date)
var month = calendario.component(.month, from: date)
var year = calendario.component(.year, from: date)


