//
//  AudioCaptureManager.swift
//  Shizima
//
//  Created by Loris Perret on 12/05/2025.
//

import AVFoundation
import SwiftUI

class AudioCaptureManager: ObservableObject {
    
    // MARK: - Singleton
    
    static let shared = AudioCaptureManager()
    private init() {}

    // MARK: - Properties
    
    @Published var isScanning: Bool = false
    @Published var isGrantedPermission: Bool = false

    private var audioRecorder: AVAudioRecorder?
    private var recordingTimer: Timer?
    private var audioFileURL: URL?
    
    var completion: (URL) -> Void = { _ in }
    
    // MARK: - Methods
    
    func startRecording(duration: TimeInterval = 10.0, completion: @escaping (URL) -> Void) {
        AVAudioApplication.requestRecordPermission { [weak self] granted in
            guard granted else {
                print("Permission not granted.")
                self?.isGrantedPermission = true
                return
            }
            
            guard let self else { return }
            
            self.completion = completion
            
            DispatchQueue.main.async {
                self.setupAndStartRecording(duration: duration)
            }
        }
    }

    private func setupAndStartRecording(duration: TimeInterval) {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)

            let tempDir = FileManager.default.temporaryDirectory
            let fileName = UUID().uuidString + ".wav"
            let url = tempDir.appendingPathComponent(fileName)
            audioFileURL = url

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatLinearPCM), // WAV format
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVLinearPCMBitDepthKey: 16,
                AVLinearPCMIsBigEndianKey: false,
                AVLinearPCMIsFloatKey: false
            ]

            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.record()
            
            withAnimation {
                isScanning = true
            }

            // Stop recording after duration
            recordingTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
                self?.stopRecording()
            }

        } catch {
            print("Recording setup failed: \(error.localizedDescription)")
        }
    }

    func stopRecording(extract: Bool = true) {
        audioRecorder?.stop()
        audioRecorder = nil
        recordingTimer?.invalidate()
        recordingTimer = nil

        if extract {
            guard let url = audioFileURL else { return }
            
            completion(url)
        }
        
        withAnimation {
            isScanning = false
        }
    }
}
