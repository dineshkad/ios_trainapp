//
//  CoachLayoutService.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

struct CoachLayout {
    struct Berth {
        let number: Int
        let type: BerthType
    }
    let code: String
    let berths: [Berth]
}
