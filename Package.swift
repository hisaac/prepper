// swift-tools-version: 6.3

import PackageDescription

let package = Package(
	name: "prepper",
	platforms: [.macOS(.v26)],
	products: [
		.executable(name: "prepper", targets: ["PrepperCLI"]),
		.library(name: "Defaults", targets: ["Defaults"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.8.1"),
	],
	targets: [
		.executableTarget(
			name: "PrepperCLI",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			],
			path: "src/PrepperCLI/Sources"
		),

		.target(
			name: "Defaults",
			path: "src/Defaults/Sources"
		),
		.testTarget(
			name: "DefaultsIntegrationTests",
			dependencies: ["Defaults"],
			path: "src/Defaults/IntegrationTests"
		),
	],
	swiftLanguageModes: [.v6]
)
