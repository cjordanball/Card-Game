//
//  AspectVGrid.swift
//  Card Game
//
//  Created by BallWebDev on 10/13/21.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items;
        self.aspectRatio = aspectRatio;
        self.content = content;
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = desiredWidth(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio);
                Spacer(minLength: 0);
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item)
                            .aspectRatio(aspectRatio, contentMode: .fit);
                    }
                }
                Spacer(minLength: 0);
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0;
        return gridItem
    }
    
    // TODO: - Create function that determines optimal width
    private func desiredWidth(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        return 80;
    }
}
