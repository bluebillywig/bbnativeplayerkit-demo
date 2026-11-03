# bbnativeplayerkit-demo

Standalone demo app for the Blue Billywig iOS SDK (BBNativePlayerKit). It consumes the published SDK through Swift Package Manager.

## How to use

- Clone or download the project.
- Open `bbnativeplayerkit-demo.xcodeproj`. Xcode resolves the Swift package on first open. There is no workspace and no `pod install`.
- Run the `bbnativeplayerkit-demo` scheme on an iOS 15.0 or later simulator or device.
- Checkout from before the switch to Swift Package Manager? Delete the CocoaPods leftovers at the repo root: `Pods/`, `Podfile.lock` and `bbnativeplayerkit-demo.xcworkspace`. That old workspace still points at Pods and fails to build.
- On a real device the app asks for Bluetooth permission once the SDK starts Google Cast discovery. That is the standard Cast SDK in the linked product (see below); the simulator never asks.

## SDK version

The SDK comes from the package https://github.com/bluebillywig/bbnativeplayerkit-cocoapod, pinned to Exact Version 8.62.0. Bump it after each sprint release in these places:

- `bbnativeplayerkit-demo.xcodeproj/project.pbxproj`: the `exactVersion` of the package reference (in Xcode: project settings, Package Dependencies) and `MARKETING_VERSION` in the Debug and Release configurations of the app target.
- `bbnativeplayerkit-demo.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved`: Xcode rewrites it when it resolves the new version. Commit it.

The package has two products. This app links `BlueBillywigNativePlayerKit-iOS` (Google Cast with Bluetooth). A `BlueBillywigNativePlayerKit-iOS-NoBluetooth` product (Google Cast without Bluetooth) is planned for 8.63.0 and is not in any tagged version yet. Link one of the two, never both.
