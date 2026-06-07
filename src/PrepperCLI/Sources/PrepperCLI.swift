import ArgumentParser

@main
struct PrepperCLI: AsyncParsableCommand {
	mutating func run() async throws {
		print("Hello from the prepper CLI!")
	}
}
