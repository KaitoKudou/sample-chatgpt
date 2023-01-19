//
//  ContentView.swift
//  sample-chatgpt-app
//
//  Created by 工藤 海斗 on 2023/01/15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(viewModel.messages, id: \.self) { message in
                    Text(message)
                    Divider()
                    Spacer()
                }
            }
            HStack {
                TextField("Type here...", text: $viewModel.text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("send") {
                    viewModel.send()
                }
                .disabled(viewModel.text.isEmpty)
            }
            .padding()
        }
        .padding()
        .onAppear {
            viewModel.setup()
        }
        .overlayLoading(isLoading: viewModel.isLoading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
