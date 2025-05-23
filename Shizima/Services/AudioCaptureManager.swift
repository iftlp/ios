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
                AVNumberOfChannelsKey: 2,
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
            
            convertAudio(at: url)
            completion(url)
        }
        
        withAnimation {
            isScanning = false
        }
    }
    
    private func convertAudio(at url: URL) {
        guard let data = try? Data(contentsOf: url),
              let fmtIndex = data.range(of: Data("fmt ".utf8)),
              let dataIndex = data.range(of: Data("data".utf8)),
              fmtIndex.count >= 4, dataIndex.count >= 4 else { return }

        let fmtOffset = fmtIndex.lowerBound
        let dataOffset = dataIndex.lowerBound

        let fmtSize = Int(data.subdata(in: (fmtOffset + 4)..<(fmtOffset + 8)).withUnsafeBytes { $0.load(as: UInt32.self) })
        let fmtChunk = data.subdata(in: fmtOffset..<(fmtOffset + 8 + fmtSize))

        let dataSize = Int(data.subdata(in: (dataOffset + 4)..<(dataOffset + 8)).withUnsafeBytes { $0.load(as: UInt32.self) })
        let audioData = data.subdata(in: (dataOffset + 8)..<(dataOffset + 8 + dataSize))

        // Construct new RIFF header
        var result = Data()
        result += Data("RIFF".utf8)
        let totalSize = 4 + fmtChunk.count + 8 + audioData.count
        result += withUnsafeBytes(of: UInt32(totalSize).littleEndian) { Data($0) }
        result += Data("WAVE".utf8)
        result += fmtChunk
        result += Data("data".utf8)
        result += withUnsafeBytes(of: UInt32(audioData.count).littleEndian) { Data($0) }
        result += audioData
        
        if FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.removeItem(at: url)
        }
        
        FileManager.default.createFile(atPath: url.path, contents: result)
    }
}
