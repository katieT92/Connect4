//
//  Model.swift
//  Connect4
//
//  Created by Katie Trombetta on 4/16/21.
//

import Foundation

struct Model {
    
    
    struct Circle: Identifiable {
        var id: Int
        var circleType: CircleType
        var color: String
        var stroke: String
    }
    
    
    enum CircleType {
        case mainMenuCircle
    }
    
}
