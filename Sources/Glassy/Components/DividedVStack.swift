//
//  DividedVStack.swift
//
//
//  Created by Kai Azim on 2024-04-02.
//

import SwiftUI

// Thank you https://movingparts.io/variadic-views-in-swiftui
struct DividedVStack<Content: View>: View {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        _VariadicView.Tree(DividedVStackLayout()) {
            content
        }
    }
}

struct DividedVStackLayout: _VariadicView_UnaryViewRoot {
    let cornerRadius: CGFloat = 12
    let innerPadding: CGFloat = 4

    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        let first = children.first?.id
        let last = children.last?.id

        VStack(spacing: self.innerPadding) {
            ForEach(children) { child in
                child
//                    .frame(minHeight: elementMinHeight)
                    .mask {
                        if first == last {
                            UnevenRoundedRectangle(
                                topLeadingRadius: cornerRadius - innerPadding,
                                bottomLeadingRadius: cornerRadius - innerPadding,
                                bottomTrailingRadius: cornerRadius - innerPadding,
                                topTrailingRadius: cornerRadius - innerPadding,
                                style: .continuous
                            )
                        } else if child.id == first {
                            UnevenRoundedRectangle(
                                topLeadingRadius: cornerRadius - innerPadding,
                                bottomLeadingRadius: innerPadding,
                                bottomTrailingRadius: innerPadding,
                                topTrailingRadius: cornerRadius - innerPadding,
                                style: .continuous
                            )
                        } else if child.id == last {
                            UnevenRoundedRectangle(
                                topLeadingRadius: innerPadding,
                                bottomLeadingRadius: cornerRadius - innerPadding,
                                bottomTrailingRadius: cornerRadius - innerPadding,
                                topTrailingRadius: innerPadding,
                                style: .continuous
                            )
                        } else {
                            UnevenRoundedRectangle(
                                topLeadingRadius: innerPadding,
                                bottomLeadingRadius: innerPadding,
                                bottomTrailingRadius: innerPadding,
                                topTrailingRadius: innerPadding,
                                style: .continuous
                            )
                        }
                    }
                    .padding(.horizontal, innerPadding) // already applied vertically with spacing

                if child.id != last {
                    Divider()
                }
            }
        }
        .padding(.vertical, innerPadding)
    }
}