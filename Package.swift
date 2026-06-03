// swift-tools-version: 6.3

import PackageDescription

let package = Package(
	name: "prepper",
	platforms: [.macOS(.v26)],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.8.1"),
		.package(url: "https://github.com/swiftlang/swift-subprocess.git", from: "0.5.0"),
	],
	targets: [
		.executableTarget(
			name: "prepper",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "Subprocess", package: "swift-subprocess"),
			]
		),
		.testTarget(
			name: "prepperTests",
			dependencies: ["prepper"]
		),
	],
	swiftLanguageModes: [.v6]
)
