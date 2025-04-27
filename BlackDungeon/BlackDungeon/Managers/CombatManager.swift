import SpriteKit

/// CombatManager - All combat logic (attacks, turns, reset)
class CombatManager {
	private unowned let scene: GameScene

	init(scene: GameScene) {
		self.scene = scene
	}

	func performAttack() {
		if scene.isHeroTurn {
			if scene.hero.currentEnergy >= 1 {
				scene.hero.currentEnergy -= 1
				scene.uiManager.updateBarsForHero(for: scene.hero)

				let avgDamage = (CGFloat(scene.hero.maxDamage) + CGFloat(scene.hero.minDamage)) / 2
				let damageDealt = max(0, avgDamage - CGFloat(scene.enemy.armor))
				scene.enemy.currentHealth = max(0, scene.enemy.currentHealth - Int(damageDealt))
				scene.uiManager.updateBarsForEnemy(for: scene.enemy)
			}
		} else {
			if scene.enemy.currentEnergy >= 1 {
				scene.enemy.currentEnergy -= 1
				scene.uiManager.updateBarsForEnemy(for: scene.enemy)

				let avgDamage = (CGFloat(scene.enemy.maxDamage) + CGFloat(scene.enemy.minDamage)) / 2
				let damageDealt = max(0, avgDamage - CGFloat(scene.hero.armor))
				scene.hero.currentHealth = max(0, scene.hero.currentHealth - Int(damageDealt))
				scene.uiManager.updateBarsForHero(for: scene.hero)
			}
		}

		if scene.hero.currentHealth == 0 {
			scene.uiManager.gameOver(isPlayerVictory: false)
		} else if scene.enemy.currentHealth == 0 {
			scene.uiManager.gameOver(isPlayerVictory: true)
		}
	}

	func endCurrentTurn() {
		if scene.isHeroTurn {
			scene.isHeroTurn = false
			scene.enemy.currentEnergy = scene.enemy.maxEnergy
			scene.uiManager.updateBarsForEnemy(for: scene.enemy)
		} else {
			scene.isHeroTurn = true
			scene.hero.currentEnergy = scene.hero.maxEnergy
			scene.currentRound += 1
			scene.uiManager.roundLabel.text = "Round: \(scene.currentRound)"
			scene.uiManager.updateBarsForHero(for: scene.hero)
		}
		scene.uiManager.updateButtonBorders()
	}

	func resetGame() {
		scene.currentRound = 1
		scene.currentRoom = 1
		scene.uiManager.roundLabel.text = "Round: 1"
		scene.uiManager.roomLabel.text = "Room: 1"
		scene.isHeroTurn = true

		scene.hero.currentHealth = scene.hero.maxHealth
		scene.hero.currentMana = scene.hero.maxMana
		scene.hero.currentEnergy = scene.hero.maxEnergy
		scene.uiManager.updateBarsForHero(for: scene.hero)

		scene.enemy.currentHealth = scene.enemy.maxHealth
		scene.enemy.currentMana = scene.enemy.maxMana
		scene.enemy.currentEnergy = scene.enemy.maxEnergy
		scene.uiManager.updateBarsForEnemy(for: scene.enemy)

		scene.uiManager.updateButtonBorders()
		scene.uiManager.gameOverScreen.isHidden = true
	}
}
