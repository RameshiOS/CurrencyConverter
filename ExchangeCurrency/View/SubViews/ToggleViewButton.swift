//
//  ToggleViewButton.swift
//  ExchangeCurrency
//
//  Created by Ramesh Guddala on 22/08/24.
//

import SwiftUI

struct ToggleViewButton: View {
    @Binding var isGridView: Bool
    
    var body: some View {
        Button(action: {
            isGridView.toggle()
        }) {
            Image(systemName: isGridView ? "list.dash" : "square.grid.2x2.fill")
                .font(.system(size: 24))
        }
    }
}
