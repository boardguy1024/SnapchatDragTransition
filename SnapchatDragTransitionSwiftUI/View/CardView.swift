//
//  CardView.swift
//  SnapchatDragTransitionSwiftUI
//
//  Created by park kyung seok on 2023/11/15.
//

import SwiftUI
import AVKit

struct CardView<Overlay: View>: View {
    
    var overlay: Overlay
    
    @Binding var videoFile: VideoFile
    @Binding var isExpanded: Bool
    
    var animationID: Namespace.ID
    var isDetailView: Bool = false
    
    init(videoFile: Binding<VideoFile>, isExpanded: Binding<Bool>, animationID: Namespace.ID, isDetailView: Bool = false, @ViewBuilder overlay: @escaping () -> Overlay) {
        
        _videoFile = videoFile
        _isExpanded = isExpanded
        self.animationID = animationID
        self.isDetailView = isDetailView
        self.overlay = overlay()
    }

    var body: some View {
        
        GeometryReader {
            let size = $0.size
            if let thumbnail = videoFile.thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                    .overlay(content: {
                        if videoFile.isPlaying, isDetailView {
                            CustomVideoPlayer(player: videoFile.player)
                        }
                    })
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Rectangle()
                    .foregroundColor(.white)
                    .onAppear {

                        Task {
                            // thumbnailのsizeをscreenSizeにする理由は、タップして画面いっぱい表示をするため
                            let image = try await extractImageAt(time: .zero, size: screenSize)
                            videoFile.thumbnail = image
                        }
                    }
            }
        }
        .matchedGeometryEffect(id: videoFile.id, in: animationID)
        
         // やや動きをつけたいので 1.1をかける （ないのがデフォルト）
        .offset(x: videoFile.offset.width, y: videoFile.offset.height * 1.1)
        .scaleEffect(scale)
    }
    
    var scale: CGFloat {
        
        let minOffsetY = videoFile.offset.height
        
        let progress = 1 - (minOffsetY / screenSize.height)
      
        // scaleのminを 0.3に設定
        return isExpanded ? progress < 0.3 ? 0.3 : progress : 1
    }
    
    @MainActor
    func extractImageAt(time: CMTime, size: CGSize) async throws -> UIImage {
        let asset = AVAsset(url: videoFile.fileUrl)
        let generator = AVAssetImageGenerator(asset: asset)
        // ビデオが撮影された時のデバイスの向きに基づいて、ビデオの表示向きを確保する
        // trueにするt、ビデオを向きを正しく自動調整
        generator.appliesPreferredTrackTransform = true
        // 最大サイズは、CardViewのSizeに設定
        generator.maximumSize = size
        
        let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
        return UIImage(cgImage: cgImage)
    }
}


extension View {
    var screenSize: CGSize {
        guard let size = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen.bounds.size else { return .zero }
        return size
    }
}
#Preview {
    ContentView  ()
}


