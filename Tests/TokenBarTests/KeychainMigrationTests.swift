import Testing
@testable import TokenBar

struct KeychainMigrationTests {
    @Test
    func `migration list covers known keychain items`() {
        let items = Set(KeychainMigration.itemsToMigrate.map(\.label))
        let expected: Set = [
            "com.tokenbar.TokenBar:codex-cookie",
            "com.tokenbar.TokenBar:claude-cookie",
            "com.tokenbar.TokenBar:cursor-cookie",
            "com.tokenbar.TokenBar:factory-cookie",
            "com.tokenbar.TokenBar:minimax-cookie",
            "com.tokenbar.TokenBar:minimax-api-token",
            "com.tokenbar.TokenBar:augment-cookie",
            "com.tokenbar.TokenBar:copilot-api-token",
            "com.tokenbar.TokenBar:zai-api-token",
            "com.tokenbar.TokenBar:synthetic-api-key",
        ]

        let missing = expected.subtracting(items)
        #expect(missing.isEmpty, "Missing migration entries: \(missing.sorted())")
    }
}
