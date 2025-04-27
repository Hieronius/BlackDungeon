import SpriteKit

/// CharacterManager - Manages spawning and resetting Characters
class CharacterManager {
	private unowned let scene: GameScene
	private var enemyList: [Enemy] = []

	init(scene: GameScene) {
		self.scene = scene
		// Prepare a list of enemies
		enemyList = [
			Enemy(name: "Skeleton", maxHealth: 15, currentHealth: 15, maxMana: 0, currentMana: 0, maxEnergy: 1, currentEnergy: 1, maxDamage: 5, minDamage: 2, skills: [], spells: []),
			// ... add 15 similar enemies
		]
	}

	func setupCharacters() {
		// Hero
		scene.hero = Hero(name: "Hieronius",
						  maxHealth: 100,
						  currentHealth: 100,
						  maxMana: 50,
						  currentMana: 50,
						  maxEnergy: 3,
						  currentEnergy: 3,
						  maxDamage: 10,
						  minDamage: 5,
						  skills: [],
						  spells: [])
		// First enemy
		spawnEnemy()
	}

	func spawnEnemy() {
		guard !enemyList.isEmpty else { return }
		scene.enemy = enemyList.removeFirst()
		scene.updateManager.refreshAllBars()
	}

	func resetCharacters() {
		scene.hero.currentHealth = scene.hero.maxHealth
		scene.hero.currentMana = scene.hero.maxMana
		scene.hero.currentEnergy = scene.hero.maxEnergy
		scene.enemy.currentHealth = scene.enemy.maxHealth
		scene.enemy.currentMana = scene.enemy.maxMana
		scene.enemy.currentEnergy = scene.enemy.maxEnergy
		scene.updateManager.refreshAllBars()
	}
}
