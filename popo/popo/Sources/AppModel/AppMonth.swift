//
//  AppMonth.swift
//  popo
//
//  Created by 초이 on 2021/10/01.
//

import Foundation

enum AppMonth: Int {
    case jan = 1, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec
    
    func getNumber() -> Int {
        return rawValue
    }
    
    func getDayCount() -> Int {
        switch self {
        case .jan, .mar, .may, .jul, .aug, .oct, .dec:
            return 31
        case .apr, .jun, .sep, .nov:
            return 30
        case .feb:
            return 28
        }
    }
    
    func getFullEnglish() -> String {
        switch self {
        case .jan: return "january"
        case .feb: return "february"
        case .mar: return "march"
        case .apr: return "april"
        case .may: return "may"
        case .jun: return "june"
        case .jul: return "july"
        case .aug: return "august"
        case .sep: return "september"
        case .oct: return "october"
        case .nov: return "november"
        case .dec: return "december"
        }
    }
}
