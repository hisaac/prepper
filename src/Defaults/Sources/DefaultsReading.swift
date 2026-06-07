import Foundation

extension Defaults {
	static func read() throws -> [String: [String: PlistValue]] {
		var result: [String: [String: PlistValue]] = [:]
		for domain in allDomains().keys {
			result[domain] = try read(domain: domain)
		}
		return result
	}

	static func read(
		domain: String,
	) throws -> [String: PlistValue] {
		let rawValue = CFPreferencesCopyMultiple(
			nil,
			domain as CFString,
			User.current.cfString,
			Host.any.cfString
		)
		guard let rawDictionary = rawValue as? [String: AnyObject] else {
			return [:]
		}

		var result: [String: PlistValue] = [:]
		for (key, value) in rawDictionary {
			result[key] = try PlistValue(from: value)
		}
		return result
	}

	static func read(
		domain: String,
		key: String,
	) throws -> PlistValue? {
		guard let rawValue = CFPreferencesCopyValue(
			key as CFString,
			domain as CFString,
			User.current.cfString,
			Host.any.cfString
		) else {
			return nil
		}
		return try PlistValue(from: rawValue)
	}

	static func allDomains(
		user: User = .current,
		host: Host = .current,
	) -> [String: [URL]] {
		guard let cfDictionary = _CFPreferencesCopyApplicationMap(
			user.cfString,
			host.cfString,
		)?.takeRetainedValue() else {
			return [:]
		}

		guard let dictionary = cfDictionary as? [String: [URL]] else {
			return [:]
		}

		return dictionary
	}
}

@_silgen_name("_CFPreferencesCopyApplicationMap")
private func _CFPreferencesCopyApplicationMap(
	_ userName: CFString,
	_ hostName: CFString,
) -> Unmanaged<CFDictionary>?
