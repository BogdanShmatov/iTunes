//
//  AudioPlayer.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 03.10.2024.
//  Copyright © 2024 iTunes. All rights reserved.
//

import SwiftUI
import AVFoundation

public class AudioPlayer: ObservableObject {
    private var player: AVPlayer?
    private var playlist: [URL] = []
    private var currentIndex = 0
    
    @Published var isPlaying = false
    
    func loadPlaylist(currentURL: String, urls: [String]) {
        self.currentIndex = urls.firstIndex(of: currentURL) ?? 0
        playlist = urls.compactMap { URL(string: $0) }
        playCurrentTrack()
    }
    
    func playCurrentTrack() {
        guard !playlist.isEmpty else { return }
        let url = playlist[currentIndex]
        player = AVPlayer(url: url)
        player?.play()
        isPlaying = true
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func playNext() {
        currentIndex = (currentIndex + 1) % playlist.count
        playCurrentTrack()
    }
    
    func playPrevious() {
        currentIndex = (currentIndex - 1 + playlist.count) % playlist.count
        playCurrentTrack()
    }
}
