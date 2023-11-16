//
//  Home.swift
//  SnapchatDragTransitionSwiftUI
//
//  Created by park kyung seok on 2023/11/15.
//

import SwiftUI

struct Home: View {
    
    @State private var videoFiles: [VideoFile] = files
    @State private var isExpanded: Bool = false
    @State private var expendedID: String?
    @Namespace private var namespace
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 2), spacing: 10) {
                    
                    ForEach($videoFiles) { $file in
                        
                        CardView(videoFile: $file, isExpanded: $isExpanded, animationID: namespace, overlay: { })
                            .frame(height: 300)
                            .transition(.identity)
                            .onTapGesture {
                                
                                withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.8)) {
                                    expendedID = file.id
                                    isExpanded = true
                                }
                            }
                    }
                }
                .padding()
            }
        }
        .overlay {
            if let expendedID, isExpanded {
                // サムネをタップするとoverlayで表示される
                VideoDetailView(videoFile: $videoFiles.index(expendedID),
                                isExpanded: $isExpanded, animationID: namespace)
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack(spacing: 12) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .circleButtonBG()
            
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .circleButtonBG()
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "person.badge.plus")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .circleButtonBG()
            }
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .circleButtonBG()
            }
            
        }
        .overlay(
            Text("Stories")
                .font(.title3)
                .fontWeight(.black)
        )
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

extension Binding<[VideoFile]> {
    
    func index(_ id: String) -> Binding<VideoFile> {
        let index = self.wrappedValue.firstIndex(where: { $0.id == id }) ?? 0
        return self[index]
    }
}

extension View {
    
    fileprivate func circleButtonBG() -> some View {
        self
            .frame(width: 40, height: 40)
            .background(
                Circle()
                    .fill(.gray.opacity(0.1))
            )
    }
}

#Preview {
    Home()
}
