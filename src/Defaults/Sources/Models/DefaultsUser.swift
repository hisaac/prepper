import Foundation

extension Defaults {
	enum User {
		case any
		case current
		case name(String)

		var cfString: CFString {
			switch self {
			case .any:
				return kCFPreferencesAnyUser
			case .current:
				return kCFPreferencesCurrentUser
			case .name(let name):
				return name as CFString
			}
		}
	}
}
