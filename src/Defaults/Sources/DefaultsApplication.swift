import Foundation

public enum DefaultsApplication {
	case any
	case current
	case name(String)

	var cfString: CFString {
		switch self {
		case .any:
			return kCFPreferencesAnyApplication
		case .current:
			return kCFPreferencesCurrentApplication
		case .name(let name):
			return name as CFString
		}
	}
}
