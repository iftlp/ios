//
//  PlayerView.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import SwiftUI
import AVFAudio
import Kingfisher

struct PlayerView: View {
    
    // MARK: - Properties

    @StateObject private var audioPlayer: AudioPlayerManager = .init()
    @State private var isSliderEditing = false
    @State private var tempSliderValue = 0.0
    private let item: Song
    private let imageUrl: URL?
    
    @Binding private var lastNavigationPath: [NavigationManager.Route]
    
    init(item: Song, lastNavigationPath: Binding<[NavigationManager.Route]>) {
        self.item = item
        if let cover = item.album?.cover {
            self.imageUrl = AwsUrl(string: cover)?.url
        } else {
            self.imageUrl = nil
        }
        self._lastNavigationPath = lastNavigationPath
    }
    
    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            KFImage(imageUrl)
                .placeholder {
                    NoImageView()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(
                    width: UIScreen.main.bounds.width - 56, // 28 + 28
                    height: 370
                )
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            VStack(spacing: 8) {
                Text(item.title)
                    .customFont(size: 20, weight: .bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(item.artists.map { $0.name }.joined(separator: ", "))
                    .customFont(size: 20, weight: .regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        if let first = item.artists.first {
                            lastNavigationPath.navigate(to: .artist(first))
                        }
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            slider
            
            button
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 28)
        .padding(.top, 20)
        .onAppear {
            setupAudio()
        }
        .onDisappear {
            audioPlayer.pause()
        }
        .navigationBarTitle("Now playing")
        .navigationBarTitleDisplayMode(.inline)
        .background(R.color.background)
    }
    
    // MARK: - Subviews
    
    private var slider: some View {
        VStack {
            if audioPlayer.duration > 0 {
                Slider(value: $audioPlayer.currentTime, in: 0 ... audioPlayer.duration, step: 1) { editing in
                    isSliderEditing = editing
                    if editing {
                        audioPlayer.pause()
                    } else {
                        audioPlayer.seek(to: audioPlayer.currentTime)
                        audioPlayer.play()
                    }
                }
                .tint(R.color.primary)
            } else {
                Slider(value: $tempSliderValue, in: 0 ... 100, step: 1) { editing in
                }
                .tint(R.color.primary)
                .disabled(audioPlayer.duration <= 0)
            }
                
            HStack {
                Text(timeString(for: audioPlayer.currentTime))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(timeString(for: audioPlayer.duration > 0 ? audioPlayer.duration : Double(item.durationInSec)))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .customFont(size: 12, weight: .regular)
        }
        .frame(height: 100, alignment: .center)
    }
    
    private var button: some View {
        Button {
            if isSliderEditing {
                audioPlayer.play()
            } else {
                audioPlayer.togglePlayback()
            }
        } label: {
            ZStack {
                Circle()
                    .fill(audioPlayer.duration > 0 ? R.color.primary : R.color.lightGrey)
                    .frame(width: 55, height: 55)
                
                if audioPlayer.isPlaying {
                    R.image.pause
                        .foregroundStyle(R.color.white)
                } else {
                    R.image.play
                        .foregroundStyle(R.color.white)
                }
            }
        }
        .disabled(audioPlayer.duration <= 0)
    }
    
    // MARK: - Methods
    
    private func setupAudio() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session setup failed.")
        }
        
        audioPlayer.loadAudio(from: item.data)
    }
    
    private func timeString(for seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    PlayerView(item: Song.Mock.previewWithAlbum(), lastNavigationPath: .constant([]))
}
