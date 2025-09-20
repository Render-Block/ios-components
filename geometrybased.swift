//
//  ListingViewItems.swift
//  components
//
//  Created by Rahul on 20/09/25.
//

import SwiftUI

struct ListingViewItems: View {
    var body: some View {
        VStack(spacing: 6) {
            // image placeholder with max width
            Rectangle()
                .frame(
                    maxWidth: 500,             // limit width (good for iPad)
                    maxHeight: 325             // proportional height
                )
                .aspectRatio(4/3, contentMode: .fit) // keeps rectangle proportion
                .clipShape(RoundedRectangle(cornerRadius: 10))

            // listing details centered
            VStack(alignment: .center, spacing: 4) {
                Text("miami, florida")
                Text("12 km, Away")
                Text("Nov 10 - 12")
                
                HStack(spacing: 2) {
                    Text("₹1234")
                        .fontWeight(.semibold)
                    Text("per night")
                }
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .frame(maxWidth: 500) // card max width (centered on iPad)
    }
}

#Preview {
    Group {
        ListingViewItems()
            .previewDevice("iPhone 14")
        ListingViewItems()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
