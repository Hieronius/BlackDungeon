import Foundation

/// Manager to handle a structured list of enemies from easiest to hardest
class GameManager {

	static let shared = GameManager() // Singleton for global access

	private var enemyList: [Enemy] = [
		
	]

	private var currentEnemyIndex = 0

	func getNextEnemy() -> Enemy? {
		guard currentEnemyIndex < enemyList.count else { return nil }
		let enemy = enemyList[currentEnemyIndex]
		currentEnemyIndex += 1
		return enemy
	}

	func resetEnemies() {
		currentEnemyIndex = 0 // Resets for new game sessions
	}
}
