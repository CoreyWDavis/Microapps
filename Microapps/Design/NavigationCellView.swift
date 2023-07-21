//
//  NavigationCellView.swift
//  Microapps
//
//  Created by Corey Davis on 7/21/23.
//

import SwiftUI

struct NavigationCellView: View {
    var name: String
    
    var body: some View {
        HStack {
            Text(name)
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
