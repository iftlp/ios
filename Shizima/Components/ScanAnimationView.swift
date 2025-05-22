//
//  ScanAnimationView.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import SwiftUI
import Combine

struct Pulse: Identifiable, Equatable {
    let id = UUID()
}

struct PulseView: View {
    var size: CGFloat
    var duration: Double

    @State private var scale: CGFloat = 1.0
    @State private var opacity: CGFloat = 0.3

    var body: some View {
        Circle()
            .fill(R.color.primary)
            .frame(width: size, height: size)
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeOut(duration: duration)) {
                    scale = 2.0
                    opacity = 0.0
                }
            }
    }
}

struct ScanAnimationView: View {
    
    // MARK: - Properties
    
    @State private var pulses: [Pulse] = []
    let pulseInterval: TimeInterval = 0.5
    let pulseDuration: TimeInterval = 1.5
    
    var pulseTimer: Publishers.Autoconnect<Timer.TimerPublisher> {
        Timer.publish(every: pulseInterval, on: .main, in: .common).autoconnect()
    }

    @State private var offset: CGFloat = 0
    @Binding var isAnimating: Bool
    @State private var currentTime: Date = Date()
    
    let minRatio: CGFloat = 1.35
    let maxRatio: CGFloat = 2
    let baseRatio: CGFloat = 1.1

    let tapAction: () -> Void
    
    // MARK: - Body

    var body: some View {
        ZStack(alignment: .top) {
            textIndicator
                .opacity(isAnimating ? 0 : 1)
                .frame(maxHeight: .infinity, alignment: .bottom)
            
            ZStack {
                if isAnimating {
                    ForEach(pulses) { pulse in
                        PulseView(size: 175, duration: 1.5)
                    }
                } else {
                    Circle()
                        .fill(R.color.primary)
                        .frame(width: 200, height: 200)
                        .opacity(0.3)
                }
                
                icon
                    .onTapGesture {
                        tapAction()
                    }
            }
            .frame(height: 350)
        }
        .frame(height: 360)
        .onReceive(pulseTimer) { now in
            guard isAnimating else { return }
            
            // Ajouter un nouveau pulse
            let pulse = Pulse()
            pulses.append(pulse)
            
            // Retirer ce pulse après la durée d'animation
            DispatchQueue.main.asyncAfter(deadline: .now() + pulseDuration) {
                pulses.removeAll { $0.id == pulse.id }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                offset = -5
            }
        }
    }
    
    // MARK: - Subviews

    private var icon: some View {
        ZStack {
            Circle()
                .fill(R.color.primary)
                .frame(width: 175, height: 175)
            
            R.image.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 140)
        }
    }
    
    private var textIndicator: some View {
        VStack(spacing: 10) {
            R.image.chevronUp
                .renderingMode(.template)
                .foregroundStyle(R.color.black)
                .offset(y: offset)
            
            Text("Tap to identify the music")
                .customFont(size: 13, weight: .regular)
        }
    }
}

#Preview {
    @Previewable @State var isAnimating = false
    ScanAnimationView(isAnimating: $isAnimating) {
        debugPrint("Tap Action")
        isAnimating = true
    }
}
