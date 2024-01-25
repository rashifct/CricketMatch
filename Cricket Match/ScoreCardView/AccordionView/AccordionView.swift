//
//  AccordionView.swift
//  Cricket Match
//
//  Created by Rashif on 24/01/24.
//

import SwiftUI

struct AccordionView<Content>: View where Content: View {
    var title: String
    @Binding var isExpanded: Bool
    var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isExpanded ? 180 : 0)) // Adjust rotation effect
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                content()
            }
        }
    }
}

