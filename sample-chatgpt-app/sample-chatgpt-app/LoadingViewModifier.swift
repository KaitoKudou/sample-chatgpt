//
//  LoadingViewModifier.swift
//  sample-chatgpt-app
//
//  Created by 工藤 海斗 on 2023/01/19.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    var isLoading: Bool

    private var loadingView: some View {
        ZStack {
            if isLoading {
                RoundedRectangle(cornerRadius: 16.0)
                    .foregroundColor(.white)
                    .opacity(0.8)

                ProgressView()
                    .scaleEffect(x: 2.0, y: 2.0, anchor: .center)
            }
        }
    }

    func body(content: Content) -> some View {
        content
            .allowsHitTesting(!isLoading)
            .overlay(loadingView)
    }
}

extension View {
    /// - Parameters:
    ///   - isLoading: 通信中か
    /// - Returns: ローディング画面
    func overlayLoading(isLoading: Bool) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading))
    }
}

struct LoadingViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .overlayLoading(isLoading: true)
    }
}

