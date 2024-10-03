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
    private var session = AVAudioSession.sharedInstance()
    private var playlist: [URL] = []
    private var currentIndex = 0
    
    @Published var isPlaying = false
    
    func loadPlaylist(currentURL: String, urls: [String]) {
        activateSession()
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
    
    private func activateSession() {
        do {
            try session.setCategory(.playback, mode: .default)
            
        } catch _ {
            print("catch")
        }
        
        do {
            try session.setActive(true)
        } catch _ {
            print("catch")
        }
    }
    
    func deactivateSession() {
        do {
            try session.setActive(false)
        } catch let error as NSError {
            print("Failed to deactivate audio session: \(error.localizedDescription)")
        }
    }
    
    deinit {
        deactivateSession()
    }
}
