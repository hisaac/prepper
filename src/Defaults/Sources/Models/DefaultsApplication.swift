import Foundation

extension Defaults {
	enum Application: String {
		case addressBook = "com.apple.AddressBook"
		case xcode = "com.apple.dt.Xcode"
	}
}

extension Defaults.Domain {
	init(from application: Defaults.Application) {
		self = .name(application.rawValue)
	}
}
