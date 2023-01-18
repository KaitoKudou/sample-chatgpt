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
            }
            .padding()
        }
        .padding()
        .onAppear {
            viewModel.setup()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
