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
    private var client: OpenAISwift?
    private let apiKey = "write API Key"

    func setup() {
        // TODO: APIKeyを追加
        client = OpenAISwift(authToken: apiKey)
    }

    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        messages.append("me: \(text)")
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result{
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                DispatchQueue.main.async {
                    self.messages.append("ChatGPT: \(output)")
                    self.text = ""
                }
            case .failure:
                break
            }
        })
    }
}
