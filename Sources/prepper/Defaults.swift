import Foundation
import Subprocess

enum Defaults {
	private static let defaults_bin = "/usr/bin/defaults"

	static func read(domain: String? = nil, key: String? = nil) async throws -> TerminationStatus {
		var args = ["read"]

		if let domain = domain {
			args.append(domain)
		}
		if let key = key {
			args.append(key)
		}

		let result = try await Subprocess.run(
			.name("defaults"),
			arguments: Arguments(args),
			output: .currentStandardOutput,
			error: .combinedWithOutput
		)
		return result.terminationStatus
	}
}
