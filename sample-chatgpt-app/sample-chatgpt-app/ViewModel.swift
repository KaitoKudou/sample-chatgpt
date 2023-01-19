//
//  ViewModel.swift
//  sample-chatgpt-app
//
//  Created by 工藤 海斗 on 2023/01/15.
//

import Foundation
import OpenAISwift

class ViewModel: ObservableObject {
    init() {}

    @Published var text = ""
    @Published var messages: [String] = []
    @Published private(set) var isLoading = false
    private var client: OpenAISwift?
    private let apiKey = "write API KEY"

    func setup() {
        // TODO: APIKeyを追加
        client = OpenAISwift(authToken: apiKey)
    }

    func send() {
        isLoading = true
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        messages.append("me: \(text)")
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result{
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                Task { @MainActor in
                    defer {
                        self.isLoading = false
                    }
                    self.messages.append("ChatGPT: \(output)")
                    self.text = ""
                }
            case .failure:
                break
            }
        })
    }
}
