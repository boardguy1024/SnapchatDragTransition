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
    
    var body: some View {
        CardView(videoFile: $videoFile, 
                 isExpanded: $isExpanded,
                 animationID: animationID,
                 isDetailView: true,
                 overlay: {
            
        })
    }
}

//#Preview {
//    VideoDetailView()
//}
