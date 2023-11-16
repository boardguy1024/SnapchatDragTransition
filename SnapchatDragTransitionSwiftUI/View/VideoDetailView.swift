//
//  VideoDetailView.swift
//  SnapchatDragTransitionSwiftUI
//
//  Created by park kyung seok on 2023/11/15.
//

import SwiftUI

struct VideoDetailView: View {
    
    @Binding var videoFile: VideoFile
    @Binding var isExpanded: Bool
    var animationID: Namespace.ID
    
    @GestureState private var isDragging: Bool = false
    
    var body: some View {
        CardView(videoFile: $videoFile, 
                 isExpanded: $isExpanded,
                 animationID: animationID,
                 isDetailView: true,
                 overlay: {
            
        })
        .gesture(
            DragGesture()
                .updating($isDragging, body: { _, out, _ in
                    out = true // updating中には isDraggingを true
                })
                .onChanged({ value in
                    videoFile.offset = isDragging ? value.translation : .zero
                })
                .onEnded({ value in
                    if screenSize.height / 2 < value.translation.height {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            isExpanded = false
                            videoFile.offset = .zero
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            videoFile.isPlaying = false
                            videoFile.player.pause()
                        }

                    } else {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            videoFile.offset = .zero
                        }
                    }
                })
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                videoFile.isPlaying = true
                videoFile.player.play()
            }
        }
        .ignoresSafeArea()
    }
}

//#Preview {
//    VideoDetailView()
//}
