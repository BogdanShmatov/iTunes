//
//  PlayerView.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 03.10.2024.
//  Copyright © 2024 iTunes. All rights reserved.
//

import SwiftUI
import Kingfisher

struct PlayerView: View {
    
    @State var isPlaying: Bool = false
    @State var selectedSong: Song?
    @State var songs: [Song] = []
    
    @StateObject private var audioPlayer = AudioPlayer()
    @State private var isFavourite: Bool = false
    
    var body: some View {
        VStack(spacing: 50) {
            
            KFImage(URL(string: selectedSong?.artworkUrl100 ?? ""))
                .resizable()
                .placeholder({
                    Color.gray
                })
                .frame(width: 356, height: 356)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)

            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(selectedSong?.trackName ?? selectedSong?.primaryGenreName ?? "")
                        .font(.title)
                        .bold()
                    Text(selectedSong?.artistName ?? "")
                        .font(.headline)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Image(isFavourite ? "heart_filled" : "heart_unfilled")
                    .onTapGesture {
                        isFavourite.toggle()
                    }
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            HStack(spacing: 40) {
                Button(action: {
                    let currentIndex = songs.firstIndex(where: { selectedSong?.previewURL ?? "" == $0.previewURL }) ?? 0
                    selectedSong = songs[currentIndex - 1]
                    audioPlayer.playPrevious()
                }) {
                    Image("control_prevs")
                        
                }
                
                Button(action: {
                    if audioPlayer.isPlaying {
                        audioPlayer.pause()
                    } else {
                        audioPlayer.play()
                    }
                }) {
                    Image(audioPlayer.isPlaying ? "control_pause" : "control_play")
                        .font(.largeTitle)
                }
                
                Button(action: {
                    let currentIndex = songs.firstIndex(where: { selectedSong?.previewURL ?? "" == $0.previewURL }) ?? 0
                    selectedSong = songs[currentIndex + 1]
                    audioPlayer.playNext()
                }) {
                    Image("control_next")
                        
                }
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            audioPlayer.loadPlaylist(currentURL:  selectedSong?.previewURL ?? "", urls:  songs.compactMap({$0.previewURL}))
        }
    }
}

#Preview {
    PlayerView()
}
