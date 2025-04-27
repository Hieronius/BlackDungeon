import SpriteKit

/// UpdateManager - Updates UI elements like health/mana/energy bars
class UpdateManager {
	private unowned let scene: GameScene

	init(scene: GameScene) {
		self.scene = scene
	}

	func refreshAllBars() {
		updateBarsForHero()
		updateBarsForEnemy()
		updateButtonBorders()
	}

	func updateBarsForHero() {
		if let energyBar = scene.hero.energyBar {
			updateBar(barNode: energyBar,
					  widthRatio: CGFloat(scene.hero.currentEnergy) / CGFloat(scene.hero.maxEnergy))
		}
		if let healthBar = scene.hero.healthBar {
			updateBar(barNode: healthBar,
					 widthRatio: CGFloat(scene.hero.currentHealth) / CGFloat(scene.hero.maxHealth))
		}
		if let manaBar = scene.hero.manaBar {
			updateBar(barNode: manaBar,
					 widthRatio: CGFloat(scene.hero.currentMana) / CGFloat(scene.hero.maxMana))
		}
	}

	func updateBarsForEnemy() {
		if let energyBar = scene.enemy.energyBar {
			updateBar(barNode: energyBar,
					  widthRatio: CGFloat(scene.enemy.currentEnergy) / CGFloat(scene.enemy.maxEnergy))
		}
		if let healthBar = scene.enemy.healthBar {
			updateBar(barNode: healthBar,
					 widthRatio: CGFloat(scene.enemy.currentHealth) / CGFloat(scene.enemy.maxHealth))
		}
		if let manaBar = scene.enemy.manaBar {
			updateBar(barNode: manaBar,
					 widthRatio: CGFloat(scene.enemy.currentMana) / CGFloat(scene.enemy.maxMana))
		}
	}

	// MARK: - Button Visual Updates
	func updateButtonBorders() {
		let color: SKColor = scene.isHeroTurn ? .white : .red
		let mgr = scene.spriteManager
		mgr.attackButton.strokeColor  = color
		mgr.endTurnButton.strokeColor = color
		mgr.blockButton.strokeColor   = color
	}

	func showGameOver(isPlayerVictory: Bool) {
		scene.spriteManager.resultLabel.text = isPlayerVictory ? "Victory" : "Defeat"
		scene.spriteManager.gameOverScreen.isHidden = false
	}

	func updateBar(barNode: SKShapeNode, widthRatio: CGFloat) {
		let clampedRatio = max(0, min(widthRatio, 1))
		let newPath = CGMutablePath()
		newPath.addRect(CGRect(x: 0, y: 0, width: 120 * clampedRatio, height: 10))
		barNode.path = newPath
	}
}
