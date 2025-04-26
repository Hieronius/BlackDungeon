import SpriteKit

class GameUIManager {
	private unowned let scene: GameScene

	init(scene: GameScene) {
		self.scene = scene
	}

	// MARK: - UI Setup
	func setupGameAreas() {
		let topHeight = scene.size.height * 0.2
		let middleHeight = scene.size.height * 0.5
		let bottomHeight = scene.size.height * 0.3

		let topArea = SKShapeNode(rect: CGRect(x: 0, y: scene.size.height - topHeight,
											 width: scene.size.width, height: topHeight))
		topArea.strokeColor = .white
		topArea.lineWidth = 2
		scene.addChild(topArea)

		let middleArea = SKShapeNode(rect: CGRect(x: 0, y: bottomHeight,
												width: scene.size.width, height: middleHeight))
		middleArea.strokeColor = .white
		middleArea.lineWidth = 2
		scene.addChild(middleArea)

		let bottomArea = SKShapeNode(rect: CGRect(x: 0, y: 0,
												width: scene.size.width, height: bottomHeight))
		bottomArea.strokeColor = .white
		bottomArea.lineWidth = 2
		scene.addChild(bottomArea)
	}

	func setupHeroUI() {
		let squareSize = CGSize(width: 100, height: 100)
		let barWidth: CGFloat = 120
		let barHeight: CGFloat = 10
		let barOffset: CGFloat = 70

		let heroPosition = CGPoint(x: scene.size.width * 0.33,
								 y: scene.size.height * 0.3 + scene.size.height * 0.5 / 2)

		// Hero sprite
		let blackSquare = SKShapeNode(rectOf: squareSize)
		blackSquare.fillColor = .black
		blackSquare.strokeColor = .white
		blackSquare.position = heroPosition

		let labelH = SKLabelNode(text: "H")
		labelH.fontName = "Helvetica-Bold"
		labelH.fontSize = 40
		labelH.fontColor = .white
		labelH.verticalAlignmentMode = .center
		labelH.horizontalAlignmentMode = .center
		blackSquare.addChild(labelH)

		// Energy Bar
		let heroEnergyBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
												 width: barWidth, height: barHeight))
		heroEnergyBg.fillColor = .darkGray
		heroEnergyBg.strokeColor = .clear
		heroEnergyBg.position = CGPoint(x: heroPosition.x - barWidth / 2,
									  y: heroPosition.y + barOffset + 15)
		scene.addChild(heroEnergyBg)

		let heroEnergy = createBarNode(width: barWidth, height: barHeight,
									 color: .orange)
		heroEnergy.position = CGPoint(x: heroPosition.x - barWidth / 2,
									y: heroPosition.y + barOffset + 15)
		scene.addChild(heroEnergy)

		// Health Bar
		let heroHealthBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
												 width: barWidth, height: barHeight))
		heroHealthBg.fillColor = .darkGray
		heroHealthBg.strokeColor = .clear
		heroHealthBg.position = CGPoint(x: heroPosition.x - barWidth / 2,
									  y: heroPosition.y + barOffset)
		scene.addChild(heroHealthBg)

		let heroHealth = createBarNode(width: barWidth, height: barHeight,
									 color: .green)
		heroHealth.position = CGPoint(x: heroPosition.x - barWidth / 2,
									y: heroPosition.y + barOffset)
		scene.addChild(heroHealth)

		// Mana Bar
		let heroManaBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
											   width: barWidth, height: barHeight))
		heroManaBg.fillColor = .darkGray
		heroManaBg.strokeColor = .clear
		heroManaBg.position = CGPoint(x: heroPosition.x - barWidth / 2,
									y: heroPosition.y + barOffset - 15)
		scene.addChild(heroManaBg)

		let heroMana = createBarNode(width: barWidth, height: barHeight,
								   color: .blue)
		heroMana.position = CGPoint(x: heroPosition.x - barWidth / 2,
								  y: heroPosition.y + barOffset - 15)
		scene.addChild(heroMana)

		// Assign to hero
		scene.hero.spriteNode = blackSquare
		scene.hero.healthBar = heroHealth
		scene.hero.manaBar = heroMana
		scene.hero.energyBar = heroEnergy

		scene.addChild(blackSquare)
	}

	func setupEnemyUI() {
		let squareSize = CGSize(width: 100, height: 100)
		let barWidth: CGFloat = 120
		let barHeight: CGFloat = 10
		let barOffset: CGFloat = 70

		let enemyPosition = CGPoint(x: scene.size.width * 0.66,
								  y: scene.size.height * 0.3 + scene.size.height * 0.5 / 2)

		// Enemy sprite
		let redSquare = SKShapeNode(rectOf: squareSize)
		redSquare.fillColor = .red
		redSquare.strokeColor = .clear
		redSquare.position = enemyPosition

		let labelE = SKLabelNode(text: "E")
		labelE.fontName = "Helvetica-Bold"
		labelE.fontSize = 40
		labelE.fontColor = .white
		labelE.verticalAlignmentMode = .center
		labelE.horizontalAlignmentMode = .center
		redSquare.addChild(labelE)

		// Energy Bar
		let enemyEnergyBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
												   width: barWidth, height: barHeight))
		enemyEnergyBg.fillColor = .darkGray
		enemyEnergyBg.strokeColor = .clear
		enemyEnergyBg.position = CGPoint(x: enemyPosition.x - barWidth / 2,
									   y: enemyPosition.y + barOffset + 15)
		scene.addChild(enemyEnergyBg)

		let enemyEnergy = createBarNode(width: barWidth, height: barHeight,
									  color: .orange)
		enemyEnergy.position = CGPoint(x: enemyPosition.x - barWidth / 2,
									 y: enemyPosition.y + barOffset + 15)
		scene.addChild(enemyEnergy)

		// Health Bar
		let enemyHealthBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
												   width: barWidth, height: barHeight))
		enemyHealthBg.fillColor = .darkGray
		enemyHealthBg.strokeColor = .clear
		enemyHealthBg.position = CGPoint(x: enemyPosition.x - barWidth / 2,
									   y: enemyPosition.y + barOffset)
		scene.addChild(enemyHealthBg)

		let enemyHealth = createBarNode(width: barWidth, height: barHeight,
									  color: .green)
		enemyHealth.position = CGPoint(x: enemyPosition.x - barWidth / 2,
									 y: enemyPosition.y + barOffset)
		scene.addChild(enemyHealth)

		// Mana Bar
		let enemyManaBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
												 width: barWidth, height: barHeight))
		enemyManaBg.fillColor = .darkGray
		enemyManaBg.strokeColor = .clear
		enemyManaBg.position = CGPoint(x: enemyPosition.x - barWidth / 2,
									 y: enemyPosition.y + barOffset - 15)
		scene.addChild(enemyManaBg)

		let enemyMana = createBarNode(width: barWidth, height: barHeight,
									color: .blue)
		enemyMana.position = CGPoint(x: enemyPosition.x - barWidth / 2,
								   y: enemyPosition.y + barOffset - 15)
		scene.addChild(enemyMana)

		// Assign to enemy
		scene.enemy.spriteNode = redSquare
		scene.enemy.healthBar = enemyHealth
		scene.enemy.manaBar = enemyMana
		scene.enemy.energyBar = enemyEnergy

		scene.addChild(redSquare)
	}

	func setupButtons() {
		let topHeight = scene.size.height * 0.2
		let bottomHeight = scene.size.height * 0.3
		let buttonSize = CGSize(width: 200, height: 60)

		scene.attackButton = SKShapeNode(rectOf: buttonSize, cornerRadius: 10)
		scene.attackButton.position = CGPoint(x: scene.size.width / 2,
											y: bottomHeight / 2 + 40)
		scene.attackButton.fillColor = .clear
		scene.attackButton.strokeColor = scene.isHeroTurn ? .white : .red
		scene.attackButton.lineWidth = 3
		scene.attackButton.name = "attackButton"
		let attackLabel = SKLabelNode(text: "Attack")
		attackLabel.fontName = "Helvetica-Bold"
		attackLabel.fontSize = 30
		attackLabel.verticalAlignmentMode = .center
		attackLabel.position = .zero
		scene.attackButton.addChild(attackLabel)
		scene.addChild(scene.attackButton)

		scene.roundLabel = SKLabelNode(text: "Round: \(scene.currentRound)")
		scene.roundLabel.fontName = "Helvetica-Bold"
		scene.roundLabel.fontSize = 30
		scene.roundLabel.position = CGPoint(x: scene.size.width / 2,
										   y: scene.size.height - topHeight / 2)
		scene.addChild(scene.roundLabel)

		scene.endTurnButton = SKShapeNode(rectOf: buttonSize, cornerRadius: 10)
		scene.endTurnButton.position = CGPoint(x: scene.size.width / 2,
											 y: scene.roundLabel.position.y - 50)
		scene.endTurnButton.fillColor = .clear
		scene.endTurnButton.strokeColor = scene.isHeroTurn ? .white : .red
		scene.endTurnButton.lineWidth = 3
		scene.endTurnButton.name = "endTurnButton"
		let endTurnLabel = SKLabelNode(text: "End Turn")
		endTurnLabel.fontName = "Helvetica-Bold"
		endTurnLabel.fontSize = 30
		endTurnLabel.verticalAlignmentMode = .center
		endTurnLabel.position = .zero
		scene.endTurnButton.addChild(endTurnLabel)
		scene.addChild(scene.endTurnButton)
	}

	func setupResultScreen() {
		// Container
		scene.gameOverScreen.position = CGPoint(x: scene.size.width / 2,
											  y: scene.size.height / 2)
		scene.gameOverScreen.zPosition = 100
		scene.gameOverScreen.isHidden = true
		scene.addChild(scene.gameOverScreen)

		// Background
		let bg = SKShapeNode(rectOf: CGSize(width: 300, height: 200),
						   cornerRadius: 20)
		bg.fillColor = SKColor(white: 0.1, alpha: 0.9)
		bg.strokeColor = .white
		bg.lineWidth = 2
		scene.gameOverScreen.addChild(bg)

		// Result Label
		scene.resultLabel.fontName = "Helvetica-Bold"
		scene.resultLabel.fontSize = 40
		scene.resultLabel.position = CGPoint(x: 0, y: 50)
		scene.gameOverScreen.addChild(scene.resultLabel)

		// Action Button
		scene.actionButton = SKShapeNode(path: UIBezierPath(
			roundedRect: CGRect(x: -100, y: -30, width: 200, height: 60),
									  cornerRadius: 10).cgPath)
		scene.actionButton.fillColor = .darkGray
		scene.actionButton.strokeColor = .white
		scene.actionButton.lineWidth = 2
		scene.actionButton.position = CGPoint(x: 0, y: -30)
		scene.actionButton.name = "actionButton"
		scene.gameOverScreen.addChild(scene.actionButton)

		let buttonLabel = SKLabelNode(text: "")
		buttonLabel.fontName = "Helvetica-Bold"
		buttonLabel.fontSize = 30
		buttonLabel.verticalAlignmentMode = .center
		buttonLabel.position = .zero
		scene.actionButton.addChild(buttonLabel)
	}

	// MARK: - Bar Utilities
	func createBarNode(width: CGFloat, height: CGFloat, color: SKColor) -> SKShapeNode {
		let path = CGMutablePath()
		path.addRect(CGRect(x: 0, y: 0, width: width, height: height))
		let bar = SKShapeNode(path: path)
		bar.fillColor = color
		bar.strokeColor = .clear
		bar.lineWidth = 0
		return bar
	}

	func updateBar(barNode: SKShapeNode, widthRatio: CGFloat) {
		let clampedRatio = max(0, min(widthRatio, 1))
		let newPath = CGMutablePath()
		newPath.addRect(CGRect(x: 0, y: 0, width: 120 * clampedRatio, height: 10))
		barNode.path = newPath
	}

	func updateBarsForHero(for character: Hero) {
		if let energyBar = character.energyBar {
			let ratio = CGFloat(character.currentEnergy) / CGFloat(character.maxEnergy)
			updateBar(barNode: energyBar, widthRatio: ratio)
		}

		if let healthBar = character.healthBar {
			let ratio = CGFloat(character.currentHealth) / CGFloat(character.maxHealth)
			updateBar(barNode: healthBar, widthRatio: ratio)
		}

		if let manaBar = character.manaBar {
			let ratio = CGFloat(character.currentMana) / CGFloat(character.maxMana)
			updateBar(barNode: manaBar, widthRatio: ratio)
		}
	}

	func updateBarsForEnemy(for character: Enemy) {
		if let energyBar = character.energyBar {
			let ratio = CGFloat(character.currentEnergy) / CGFloat(character.maxEnergy)
			updateBar(barNode: energyBar, widthRatio: ratio)
		}

		if let healthBar = character.healthBar {
			let ratio = CGFloat(character.currentHealth) / CGFloat(character.maxHealth)
			updateBar(barNode: healthBar, widthRatio: ratio)
		}

		if let manaBar = character.manaBar {
			let ratio = CGFloat(character.currentMana) / CGFloat(character.maxMana)
			updateBar(barNode: manaBar, widthRatio: ratio)
		}
	}

	func updateButtonBorders() {
		let borderColor: SKColor = scene.isHeroTurn ? .white : .red
		scene.attackButton.strokeColor = borderColor
		scene.endTurnButton.strokeColor = borderColor
	}

	func gameOver(isPlayerVictory: Bool) {
		scene.isUserInteractionEnabled = false

		scene.resultLabel.text = isPlayerVictory ? "You Won!" : "Game Over"
		scene.resultLabel.fontColor = isPlayerVictory ? .green : .red

		if let buttonLabel = scene.actionButton.children.first as? SKLabelNode {
			buttonLabel.text = isPlayerVictory ? "Enter New Room" : "Try Again"
		}

		scene.gameOverScreen.isHidden = false

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.scene.isUserInteractionEnabled = true
		}
	}
}
