import Testing
@testable import Defaults

struct ReadIntegrationTests {
	@Test func testReadKey() throws {
		let result = try Defaults.read(domain: ".GlobalPreferences_m", key: "AppleLocale")
		#expect(result != nil)
	}

	@Test func testReadDomain() throws {
		let result = try Defaults.read(domain: ".GlobalPreferences_m")
		#expect(result.isEmpty == false)
	}

	@Test func testRead() throws {
		let result = try Defaults.read()
		#expect(result.isEmpty == false)
	}
}
