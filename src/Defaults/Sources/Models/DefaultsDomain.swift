import Foundation

extension Defaults {
	enum Domain {
		case any
		case current
		case name(String)

		// Alias to `.any`
		case global

		var cfString: CFString {
			switch self {
			case .any, .global:
				return kCFPreferencesAnyApplication
			case .current:
				return kCFPreferencesCurrentApplication
			case .name(let name):
				return name as CFString
			}
		}
	}
}
