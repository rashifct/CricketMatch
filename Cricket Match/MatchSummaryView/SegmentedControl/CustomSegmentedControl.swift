//
//  CustomSegmentedControl.swift
//  Cricket Match
//
//  Created by Rashif on 23/01/24.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var selectedSegment: String
    let segments: [String]

    var body: some View {
        HStack {
            ForEach(segments, id: \.self) { segment in
                Text(segment)
                    .padding()
                    .font(.system(size: 13).weight(.bold))
                    .frame(maxWidth: .infinity)
                    .background(self.selectedSegment == segment ? Color.cyan : Color.white)
                    .foregroundColor(self.selectedSegment == segment ? Color.white : Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation {
                            self.selectedSegment = segment
                        }
                    }
            }
        }
        .frame(height: 45)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 4)
    }
}

