//
//  VideoFile.swift
//  SnapchatDragTransitionSwiftUI
//
//  Created by park kyung seok on 2023/11/15.
//

import SwiftUI
import AVKit

struct VideoFile: Identifiable {
    var id = UUID().uuidString
    var fileUrl: URL
    var thumbnail: UIImage?
    var player: AVPlayer
    var offset: CGSize = .zero
    var isPlaying: Bool = false
}

var videoUrl1 = Bundle.main.url(forResource: "Reel1", withExtension: "mp4")!
var videoUrl2 = Bundle.main.url(forResource: "Reel2", withExtension: "mp4")!
var videoUrl3 = Bundle.main.url(forResource: "Reel3", withExtension: "mp4")!
var videoUrl4 = Bundle.main.url(forResource: "Reel4", withExtension: "mp4")!
var videoUrl5 = Bundle.main.url(forResource: "Reel5", withExtension: "mp4")!


var files: [VideoFile] = [
    .init(fileUrl: videoUrl1, player: AVPlayer(url: videoUrl1)),
    .init(fileUrl: videoUrl2, player: AVPlayer(url: videoUrl2)),
    .init(fileUrl: videoUrl3, player: AVPlayer(url: videoUrl3)),
    .init(fileUrl: videoUrl4, player: AVPlayer(url: videoUrl4)),
    .init(fileUrl: videoUrl5, player: AVPlayer(url: videoUrl5)),
]


