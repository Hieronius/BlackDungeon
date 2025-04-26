import Foundation

/// Manager to handle a structured list of enemies from easiest to hardest
class GameManager {

	static let shared = GameManager() // Singleton for global access

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

	private var enemyList: [Enemy] = [
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 15, currentHealth: 15, maxMana: 15, currentMana: 15, maxDamage: 10, minDamage: 5, maxEnergy: 5, currentEnergy: 5, blockChance: 5, criticalRate: 5, armor: 1, skills: [], spells: [], weaponType: .sword, inventory: []),
		Enemy(type: .skeleton, maxHealth: 150, currentHealth: 150, maxMana: 150, currentMana: 150, maxDamage: 50, minDamage: 25, maxEnergy: 5, currentEnergy: 5, blockChance: 25, criticalRate: 25, armor: 5, skills: [], spells: [], weaponType: .sword, inventory: [])
	]
}
