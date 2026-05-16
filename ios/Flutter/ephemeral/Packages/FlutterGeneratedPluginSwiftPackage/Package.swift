// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "video_player_avfoundation", path: "../.packages/video_player_avfoundation-2.9.4"),
        .package(name: "url_launcher_ios", path: "../.packages/url_launcher_ios-6.4.1"),
        .package(name: "sqflite_darwin", path: "../.packages/sqflite_darwin-2.4.2"),
        .package(name: "shared_preferences_foundation", path: "../.packages/shared_preferences_foundation-2.5.6"),
        .package(name: "image_picker_ios", path: "../.packages/image_picker_ios-0.8.13+6"),
        .package(name: "connectivity_plus", path: "../.packages/connectivity_plus-6.1.5"),
        .package(name: "FlutterFramework", path: "../.packages/FlutterFramework")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "video-player-avfoundation", package: "video_player_avfoundation"),
                .product(name: "url-launcher-ios", package: "url_launcher_ios"),
                .product(name: "sqflite-darwin", package: "sqflite_darwin"),
                .product(name: "shared-preferences-foundation", package: "shared_preferences_foundation"),
                .product(name: "image-picker-ios", package: "image_picker_ios"),
                .product(name: "connectivity-plus", package: "connectivity_plus"),
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
