import ArgumentParser

@main
struct prepper: AsyncParsableCommand {
	mutating func run() async throws {
		_ = try await Defaults.read(domain: "com.apple.dock", key: "autohide")
	}
}
