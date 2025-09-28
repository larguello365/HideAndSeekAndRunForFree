# Hide and Seek and Run For Free - Interactive iPadOS Storybook


### **iPadOS Features Implementation**

**🎨 Custom Drawing System**
- Built a complete touch-based drawing view with delegate pattern
- Implemented path tracking and real-time rendering using Core Graphics
- Created parental gate using sequential number tracing validation

**🔊 Accessibility-First Design**
- Full AVSpeechSynthesizer integration with character-range highlighting
- Dual narration modes (automatic/tap-to-play) with UserDefaults persistence
- Real-time text highlighting synchronized with speech output
- WCAG-compliant UI elements for inclusive user experience

**🎯 Physics-Based Interactions**
- UIDynamics implementation for realistic bullet physics
- Custom gravity and collision behaviors
- Interactive tap-based shooting mechanics with visual/audio feedback

**📖 Natural Page Navigation**
- UIPageViewController with authentic page-curl transitions
- Programmatic navigation with smooth animations
- Memory-efficient page management for scalable content

### 🏗 Architecture & Design Patterns


- MVC Architecture with clear separation of concerns
- Delegate Pattern for DrawingView and AVSpeechSynthesizer
- Error Handling with custom Swift error types
- Memory Management with weak references and proper cleanup
- Observer Pattern for settings synchronization


### 🔧 Swift SDKs and Tech Skills used

| Skill Category | Technologies |
|----------------|-------------|
| **UI Frameworks** | UIKit, SwiftUI, Storyboards, Programmatic UI |
| **Graphics & Animation** | SpriteKit, Core Graphics, UIDynamics, Core Animation |
| **Audio & Accessibility** | AVFoundation, AVSpeechSynthesizer, AVAudioPlayer |
| **Architecture** | MVC, Delegate Pattern, Error Handling, Memory Management |
| **Data Persistence** | UserDefaults, Settings Management |
| **Swift APIs** | Gesture Recognizers, Touch Handling, Scene Management

### 🛠 Development Environment

- **Language**: Swift 5.0+
- **Minimum iOS**: 13.0+
- **Xcode**: 14.0+
- **Frameworks**: UIKit, SwiftUI, SpriteKit, AVFoundation, Core Graphics

### 🚀 Getting Started

Clone this repository, and build and run the .xcodeproj file in Xcode to experience the interactive storybook.