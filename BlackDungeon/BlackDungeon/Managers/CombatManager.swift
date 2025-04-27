import SpriteKit

/// CombatManager - Handles attacks, turns, and game reset
class CombatManager {
	private unowned let scene: GameScene
	private let maxFights = 15
	private var fightCount = 0

	init(scene: GameScene) {
		self.scene = scene
	}

	func startFirstTurn() {
		scene.isUserInteractionEnabled = true
		fightCount = 0
	}

	func performAttack() {
		if scene.isHeroTurn {
			if scene.hero.currentEnergy > 0 {
				scene.hero.currentEnergy -= 1

				let damage = (scene.hero.maxDamage + scene.hero.minDamage) / 2
				scene.enemy.currentHealth -= damage
				scene.updateManager.refreshAllBars()
			}
		} else {
			if scene.enemy.currentEnergy > 0 {
				scene.enemy.currentEnergy -= 1

				let damage = (scene.enemy.maxDamage + scene.enemy.minDamage) / 2
				scene.hero.currentHealth -= damage
				scene.updateManager.refreshAllBars()
			}
		}
		checkFightEnd()
	}

	func endCurrentTurn() {
		scene.isUserInteractionEnabled = false
		scene.gameManager.toggleTurn()
		fightCount += 1
		if scene.isHeroTurn {
			scene.hero.currentEnergy = scene.hero.maxEnergy
			scene.gameManager.nextRound()
		} else {
			scene.enemy.currentEnergy = scene.enemy.maxEnergy
		}
		scene.updateManager.refreshAllBars()
		scene.isUserInteractionEnabled = true
	}

	private func checkFightEnd() {
		if scene.hero.currentHealth <= 0 || scene.enemy.currentHealth <= 0 || fightCount >= maxFights {
			let victory = scene.enemy.currentHealth <= 0
			scene.updateManager.showGameOver(isPlayerVictory: victory)
		}
	}

	func resetGame() {
		fightCount = 0
		scene.gameManager.setupRoom()
		scene.characterManager.resetCharacters()
		scene.isUserInteractionEnabled = true
	}
}
