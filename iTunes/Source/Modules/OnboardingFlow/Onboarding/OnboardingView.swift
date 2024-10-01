//
//  OnboardingView.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    var onCompletion: CompletionBlock?
    
    @State private var selectedTabItem: Int = 0
    
    @State private var tabItems: [OnboardingTabViewItem] = [
        .init(title: "Playio.", description: "Playio supports artists with tools to create,\nrelease, and measure music across a global\nstage.", tag: 0),
        .init(title: "Playio 2.", description: "Playio supports artists with tools to create,\nrelease, and measure music across a global\nstage.", tag: 1),
        .init(title: "Playio 3.", description: "Playio supports artists with tools to create,\nrelease, and measure music across a global\nstage.", tag: 2)]
    
    var body: some View {
        
        ZStack {
            Image("LaunchScreen")
            VStack {
                Button("Skip") {
                    Session.isSeenOnboarding = true
                    onCompletion?()
                }
                .foregroundStyle(.black)
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 100)
                .padding(.trailing, 28)
                .frame(maxWidth: .infinity, alignment: .trailing)
                Spacer()
                iTunesTabView()
            }
            .padding(.bottom, 100)
        }
        .ignoresSafeArea(.all)
    }
    
    @ViewBuilder
    func iTunesTabView() -> some View {
        TabView(selection: $selectedTabItem) {
            
            ForEach(tabItems, id: \.id) { tabItem in
                iTunesTabViewItem(title: tabItem.title, description: tabItem.description)
                    .tag(tabItem.tag)
            }
        }
        .animation(.smooth, value: true)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(maxHeight: 150)
        
        iTunesTabViewIndices()
    }
    
    @ViewBuilder
    func iTunesTabViewItem(title: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 17) {
            Text(title)
                .font(.system(size: 32, weight: .bold))
            Text(description)
                .font(.system(size: 16))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 28)
    }
    
    @ViewBuilder
    func iTunesTabViewIndices() -> some View {
        HStack {
            ForEach(tabItems.indices, id:\.self) { index in
                Circle()
                    .frame(width: 7, height: 7)
                    .animation(.smooth, value: true)
                    .foregroundStyle(selectedTabItem == index ? Color(red: 0.27, green: 0.15, blue: 0.63) : .gray)
                    .onTapGesture {
                        withAnimation {
                            selectedTabItem = index
                        }
                    }
            }
        }
    }
}

#Preview {
    OnboardingView()
}

struct OnboardingTabViewItem {
    let id: UUID = .init()
    let title: String
    let description: String
    let tag: Int
}
