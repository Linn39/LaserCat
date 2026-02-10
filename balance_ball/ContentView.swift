//
//  ContentView.swift
//  balance_ball
//
//  Created by Lin Zhou on 08.02.26.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    // 1. Sensor & Position State
    @State private var ballPosition = CGPoint(x: 200, y: 400)
    @State private var motion = CMMotionManager()
    
    // 2. Sensitivity Settings (Adjust these for your balance board!)
    let sensitivity: CGFloat = 50.0
    let damping: CGFloat = 0.15 // Lower = smoother/slower, Higher = twitchier
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // The "Floor"
                Color.black.ignoresSafeArea()

                // The Cat Face from asset catalog
                Image("cat_face")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .position(ballPosition)
                    .shadow(color: .white.opacity(0.3), radius: 10)
            }
            .onAppear {
                startMotionUpdates(screenSize: geometry.size)
            }
        }
    }
    
    func startMotionUpdates(screenSize: CGSize) {
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 1/60
            motion.startDeviceMotionUpdates(to: .main) { data, _ in
                guard let attitude = data?.attitude else { return }
                
                // Calculate "Target" position based on tilt
                // Pitch = Forward/Back, Roll = Left/Right
                let targetX = (screenSize.width / 2) + (CGFloat(attitude.roll) * sensitivity * 10)
                let targetY = (screenSize.height / 2) + (CGFloat(attitude.pitch) * sensitivity * 10)
                
                // 3. Applying Smoothing (Linear Interpolation)
                // Instead of jumping to target, we move a small % towards it
                withAnimation(.interactiveSpring()) {
                    ballPosition.x += (targetX - ballPosition.x) * damping
                    ballPosition.y += (targetY - ballPosition.y) * damping
                    
                    // Keep the ball on screen
                    ballPosition.x = min(max(ballPosition.x, 25), screenSize.width - 25)
                    ballPosition.y = min(max(ballPosition.y, 25), screenSize.height - 25)
                }
            }
        }
    }
}
