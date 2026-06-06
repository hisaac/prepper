import Foundation

public enum DefaultsHost {
	case any
	case current
	case name(String)

	var cfString: CFString {
		switch self {
		case .any:
			return kCFPreferencesAnyHost
		case .current:
			return kCFPreferencesCurrentHost
		case .name(let name):
			return name as CFString
		}
	}
}
