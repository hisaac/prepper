import Foundation

enum PlistValueError: Error {
	case unsupportedType(CFTypeID)
}

enum PlistValue {
	case string(String)
	case data(Data)
	case int(Int)
	case float(Float)
	case double(Double)
	case bool(Bool)
	case date(Date)
	case array([PlistValue])
	case dict([String: PlistValue])
}

extension PlistValue {
	init(from cfValue: CFPropertyList) throws {
		switch CFGetTypeID(cfValue) {
		case CFBooleanGetTypeID():
			self = .bool(CFBooleanGetValue((cfValue as! CFBoolean)))

		case CFNumberGetTypeID():
			let number = cfValue as! NSNumber
			if number.objCType.pointee == UInt8(ascii: "f") {
				self = .float(number.floatValue)
			} else if number.objCType.pointee == UInt8(ascii: "d") {
				self = .double(number.doubleValue)
			} else {
				self = .int(number.intValue)
			}

		case CFStringGetTypeID():
			self = .string(cfValue as! String)

		case CFDataGetTypeID():
			self = .data(cfValue as! Data)

		case CFDateGetTypeID():
			self = .date(cfValue as! Date)

		case CFArrayGetTypeID():
			self = .array(try (cfValue as! [CFPropertyList]).map { try PlistValue(from: $0) })

		case CFDictionaryGetTypeID():
			self = .dict(try (cfValue as! [String: CFPropertyList]).mapValues { try PlistValue(from: $0) })

		default:
			throw PlistValueError.unsupportedType(CFGetTypeID(cfValue))
		}
	}
}
