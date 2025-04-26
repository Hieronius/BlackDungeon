import SpriteKit

class CharacterManager {
	private unowned let scene: GameScene

	init(scene: GameScene) {
		self.scene = scene
	}

	func setupCharacters() {
		scene.hero = Hero(name: "Hieronius",
						 maxHealth: 100,
						 currentHealth: 100,
						 maxMana: 100,
						 currentMana: 100,
						 maxDamage: 15,
						 minDamage: 10,
						 maxEnergy: 5,
						 currentEnergy: 5,
						 blockChance: 10,
						 criticalRate: 10,
						 armor: 10,
						 skills: [],
						 spells: [],
						 weaponType: .twoHandedSword,
						 inventory: [])

		scene.enemy = Enemy(type: .skeleton,
						   maxHealth: 50,
						   currentHealth: 50,
						   maxMana: 50,
						   currentMana: 50,
						   maxDamage: 25,
						   minDamage: 20,
						   maxEnergy: 5,
						   currentEnergy: 5,
						   blockChance: 5,
						   criticalRate: 5,
						   armor: 5,
						   skills: [],
						   spells: [],
						   weaponType: .sword,
						   inventory: [])
	}

	func spawnNewEnemy() {
		scene.enemy.currentHealth = scene.enemy.maxHealth
		scene.enemy.currentMana = scene.enemy.maxMana
		scene.enemy.currentEnergy = scene.enemy.maxEnergy

		scene.hero.currentEnergy = scene.hero.maxEnergy

		scene.currentRound = 1
		scene.roundLabel.text = "Round: 1"
		scene.isHeroTurn = true

		scene.uiManager.updateBarsForEnemy(for: scene.enemy)
		scene.uiManager.updateBarsForHero(for: scene.hero)
		scene.uiManager.updateButtonBorders()
		scene.gameOverScreen.isHidden = true
	}
}
