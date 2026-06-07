import Foundation

extension Defaults {
	enum WriteError: Error {
		case synchronizationFailed(domain: Domain)
	}

	static func write(
		domain: Domain,
		key: String,
		value: PlistValue?
	) throws {
		CFPreferencesSetValue(
			key as CFString,
			value?.cfPropertyList,
			domain.cfString,
			User.current.cfString,
			Host.any.cfString
		)
		try synchronize(domain: domain)
	}

	static func overwrite(
		domain: Domain,
		contents: [String: PlistValue],
	) throws {
		let currentKeys = CFPreferencesCopyKeyList(
			domain.cfString,
			User.current.cfString,
			Host.any.cfString
		)

		let cfDictionary = contents.mapValues { $0.cfPropertyList } as CFDictionary

		CFPreferencesSetMultiple(
			cfDictionary,
			currentKeys,
			domain.cfString,
			User.current.cfString,
			Host.any.cfString
		)

		try synchronize(domain: domain)
	}

	private static func synchronize(domain: Domain) throws {
		guard CFPreferencesSynchronize(
			domain.cfString,
			User.current.cfString,
			Host.any.cfString
		) else {
			throw WriteError.synchronizationFailed(domain: domain)
		}
	}
}
