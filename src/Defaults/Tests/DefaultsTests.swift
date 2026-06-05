import Testing
@testable import Defaults

@Test
func testAllDomains() async throws {
	let domains = Defaults.allDomains()
	print(domains.count)
	#expect(domains.isEmpty == false)
}
