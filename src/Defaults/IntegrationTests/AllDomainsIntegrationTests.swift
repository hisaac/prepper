import Testing
@testable import Defaults

struct AllDomainsIntegrationTests {
	let allDomains = Defaults.allDomains()

	@Test func testAllDomainsReturnsNonEmptyResult() {
		#expect(allDomains.isEmpty == false)
	}

	@Test func testAllDomainsValuesAreNonEmpty() {
		#expect(allDomains.values.allSatisfy { $0.isEmpty == false})
	}

	@Test func testAllDomainsKeysAreNonEmpty() {
		#expect(allDomains.keys.allSatisfy { $0.isEmpty == false })
	}

	@Test func testAllDomainsValuesAreFileURLs() {
		#expect(allDomains.values.joined().allSatisfy { $0.isFileURL })
	}

	@Test func testAllDomainsContainsAppleGlobalDomain() {
		#expect(allDomains["kCFPreferencesAnyApplication"] != nil)
	}
}
