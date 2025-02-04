//
//  ContentView.swift
//  AdvancedTechniquesSwiftUI
//
//  Created by Skyler Robbins on 1/22/25.
//

import SwiftUI

enum LoginState {
    case idle, loading, success, error
}

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var loginState: LoginState = .idle
    
    var body: some View {
        VStack {
            
            Text("Login")
                .font(.largeTitle)
            TextField("Username", text: $username)
                .customStyle
            
            SecureField("Password", text: $password)
                .customStyle
            
            Button("Login") {
                loginState = .loading
                Task {
                    try? await Task.sleep(nanoseconds: 2_000_000_000) // wait for 2 seconds
                    loginState = .success
                }
            }
            
            
            Button("Forgot Password") {
                loginState = .error
            }
            
            statusView
        }
        .buttonStyle(CustomButtonStyle())
        .padding()
        Spacer()
    }
    
    @ViewBuilder
    var statusView: some View {
        switch loginState {
        case .idle:
            EmptyView()
        case .loading, .error, .success:
            Text("Status: \(loginState)")
        }
    }
}

struct CustomViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding(.horizontal)
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? .red : .purple)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
    }
}

extension View {
    var customStyle: some View {
        self.modifier(CustomViewModifier())
    }
}

#Preview {
    ContentView()
}
