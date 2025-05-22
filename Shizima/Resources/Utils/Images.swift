//
//  Images.swift
//  Shizima
//
//  Created by Loris Perret on 20/03/2025.
//

import SwiftUI

extension R2Image {
    
    var home: Image {
        Image(systemName: "pentagon")
    }
    
    var homeSelected: Image {
        Image(systemName: "pentagon.fill")
    }
    
    var history: Image {
        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
    }
    
    var historySelected: Image {
        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
    }
    
    var play: Image {
        Image(systemName: "play.fill")
    }
    
    var icon: Image {
        Image("Icon")
    }
    
    var chevronUp: Image {
        Image(systemName: "chevron.up")
    }
    
    var headphones: Image {
        Image(systemName: "headphones")
    }
    
    var magnifyingGlass: Image {
        Image(systemName: "magnifyingglass")
    }
    
    var pause: Image {
        Image(systemName: "pause.fill")
    }
    
    var noImage: Image {
        Image(systemName: "nosign")
    }
}
