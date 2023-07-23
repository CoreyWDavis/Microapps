//
//  NavigationCellView.swift
//  Microapps
//
//  Created by Corey Davis on 7/21/23.
//

import SwiftUI

public struct NavigationCellView: View {
    var name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public var body: some View {
        HStack {
            Text(name)
                .foregroundColor(ColorManager.darkBlue.color)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .contentShape(Rectangle())
    }
}

struct NavigationCellView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationCellView(name: "Tap me!")
    }
}
