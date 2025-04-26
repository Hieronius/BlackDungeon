import SpriteKit

/// GameUIManager - All UI setup and management
class GameUIManager {
	private unowned let scene: GameScene

	init(scene: GameScene) {
		self.scene = scene
	}

	// MARK: - Main UI Setup
	func setupGameAreas() {
		let topHeight = scene.size.height * 0.25
		let middleHeight = scene.size.height * 0.45
		let bottomHeight = scene.size.height * 0.3

		// MARK: Top Area
		let topArea = SKShapeNode(rect: CGRect(x: 0, y: scene.size.height - topHeight,
											 width: scene.size.width, height: topHeight))
		topArea.strokeColor = .white
		topArea.lineWidth = 2
		scene.addChild(topArea)

		// MARK: Middle Area
		let middleArea = SKShapeNode(rect: CGRect(x: 0, y: bottomHeight,
												width: scene.size.width, height: middleHeight))
		middleArea.strokeColor = .white
		middleArea.lineWidth = 2
		scene.addChild(middleArea)

		// MARK: Bottom Area
		let bottomArea = SKShapeNode(rect: CGRect(x: 0, y: 0,
												width: scene.size.width, height: bottomHeight))
		bottomArea.strokeColor = .white
		bottomArea.lineWidth = 2
		scene.addChild(bottomArea)
	}

	// MARK: - Hero UI Components
	func setupHeroUI() {
		let squareSize = CGSize(width: 100, height: 100)
		let barWidth: CGFloat = 120
		let barHeight: CGFloat = 10
		let barOffset: CGFloat = 70
		let heroPosition = CGPoint(x: scene.size.width * 0.33,
								 y: scene.size.height * 0.3 + scene.size.height * 0.5 / 2)

		// MARK: Hero Sprite
		let heroSprite = SKShapeNode(rectOf: squareSize)
		heroSprite.fillColor = .black
		heroSprite.strokeColor = .white
		heroSprite.position = heroPosition

		let heroLabel = SKLabelNode(text: "H")
		heroLabel.fontName = "Helvetica-Bold"
		heroLabel.fontSize = 40
		heroLabel.fontColor = .white
		heroLabel.verticalAlignmentMode = .center
		heroLabel.horizontalAlignmentMode = .center
		heroSprite.addChild(heroLabel)

		// MARK: Hero Energy Bar
		let heroEnergyBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
												  width: barWidth, height: barHeight))
		heroEnergyBg.fillColor = .darkGray
		heroEnergyBg.strokeColor = .clear
		heroEnergyBg.position = CGPoint(x: heroPosition.x - barWidth / 2,
									  y: heroPosition.y + barOffset + 15)
		scene.addChild(heroEnergyBg)

		let heroEnergyBar = createBarNode(width: barWidth, height: barHeight,
										color: .orange)
		heroEnergyBar.position = heroEnergyBg.position
		scene.addChild(heroEnergyBar)

		// MARK: Hero Health Bar
		let heroHealthBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
												  width: barWidth, height: barHeight))
		heroHealthBg.fillColor = .darkGray
		heroHealthBg.strokeColor = .clear
		heroHealthBg.position = CGPoint(x: heroPosition.x - barWidth / 2,
									  y: heroPosition.y + barOffset)
		scene.addChild(heroHealthBg)

		let heroHealthBar = createBarNode(width: barWidth, height: barHeight,
										color: .green)
		heroHealthBar.position = heroHealthBg.position
		scene.addChild(heroHealthBar)

		// MARK: Hero Mana Bar
		let heroManaBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
											   width: barWidth, height: barHeight))
		heroManaBg.fillColor = .darkGray
		heroManaBg.strokeColor = .clear
		heroManaBg.position = CGPoint(x: heroPosition.x - barWidth / 2,
									y: heroPosition.y + barOffset - 15)
		scene.addChild(heroManaBg)

		let heroManaBar = createBarNode(width: barWidth, height: barHeight,
									  color: .blue)
		heroManaBar.position = heroManaBg.position
		scene.addChild(heroManaBar)

		// Assign references
		scene.hero.spriteNode = heroSprite
		scene.hero.healthBar = heroHealthBar
		scene.hero.manaBar = heroManaBar
		scene.hero.energyBar = heroEnergyBar
		scene.addChild(heroSprite)
	}

	// MARK: - Enemy UI Components
	func setupEnemyUI() {
		let squareSize = CGSize(width: 100, height: 100)
		let barWidth: CGFloat = 120
		let barHeight: CGFloat = 10
		let barOffset: CGFloat = 70
		let enemyPosition = CGPoint(x: scene.size.width * 0.66,
								  y: scene.size.height * 0.3 + scene.size.height * 0.5 / 2)

		// MARK: Enemy Sprite
		let enemySprite = SKShapeNode(rectOf: squareSize)
		enemySprite.fillColor = .red
		enemySprite.strokeColor = .clear
		enemySprite.position = enemyPosition

		let enemyLabel = SKLabelNode(text: "E")
		enemyLabel.fontName = "Helvetica-Bold"
		enemyLabel.fontSize = 40
		enemyLabel.fontColor = .white
		enemyLabel.verticalAlignmentMode = .center
		enemyLabel.horizontalAlignmentMode = .center
		enemySprite.addChild(enemyLabel)

		// MARK: Enemy Energy Bar
		let enemyEnergyBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
												   width: barWidth, height: barHeight))
		enemyEnergyBg.fillColor = .darkGray
		enemyEnergyBg.strokeColor = .clear
		enemyEnergyBg.position = CGPoint(x: enemyPosition.x - barWidth / 2,
									   y: enemyPosition.y + barOffset + 15)
		scene.addChild(enemyEnergyBg)

		let enemyEnergyBar = createBarNode(width: barWidth, height: barHeight,
										 color: .orange)
		enemyEnergyBar.position = enemyEnergyBg.position
		scene.addChild(enemyEnergyBar)

		// MARK: Enemy Health Bar
		let enemyHealthBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
												   width: barWidth, height: barHeight))
		enemyHealthBg.fillColor = .darkGray
		enemyHealthBg.strokeColor = .clear
		enemyHealthBg.position = CGPoint(x: enemyPosition.x - barWidth / 2,
									   y: enemyPosition.y + barOffset)
		scene.addChild(enemyHealthBg)

		let enemyHealthBar = createBarNode(width: barWidth, height: barHeight,
										 color: .green)
		enemyHealthBar.position = enemyHealthBg.position
		scene.addChild(enemyHealthBar)

		// MARK: Enemy Mana Bar
		let enemyManaBg = SKShapeNode(rect: CGRect(x: 0, y: 0,
												 width: barWidth, height: barHeight))
		enemyManaBg.fillColor = .darkGray
		enemyManaBg.strokeColor = .clear
		enemyManaBg.position = CGPoint(x: enemyPosition.x - barWidth / 2,
									 y: enemyPosition.y + barOffset - 15)
		scene.addChild(enemyManaBg)

		let enemyManaBar = createBarNode(width: barWidth, height: barHeight,
									   color: .blue)
		enemyManaBar.position = enemyManaBg.position
		scene.addChild(enemyManaBar)

		// Assign references
		scene.enemy.spriteNode = enemySprite
		scene.enemy.healthBar = enemyHealthBar
		scene.enemy.manaBar = enemyManaBar
		scene.enemy.energyBar = enemyEnergyBar
		scene.addChild(enemySprite)
	}

	// MARK: - Button Components
	func setupButtons() {
		let topHeight = scene.size.height * 0.2
		let bottomHeight = scene.size.height * 0.3
		let topButtonSize = CGSize(width: 200, height: 60)
		let botButtonSize = CGSize(width: 100, height: 60)

		// MARK: Attack Button
		scene.attackButton = SKShapeNode(rectOf: botButtonSize, cornerRadius: 10)
		scene.attackButton.position = CGPoint(x: scene.size.width * 0.25,
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

		// MARK: Block Button
		scene.blockButton = SKShapeNode(rectOf: botButtonSize, cornerRadius: 10)
		scene.blockButton.position = CGPoint(x: scene.size.width * 0.75,
											y: bottomHeight / 2 + 40)
		scene.blockButton.fillColor = .clear
		scene.blockButton.strokeColor = scene.isHeroTurn ? .white : .red
		scene.blockButton.lineWidth = 3
		scene.blockButton.name = "blockButton"

		let blockLabel = SKLabelNode(text: "Block")
		blockLabel.fontName = "Helvetica-Bold"
		blockLabel.fontSize = 30
		blockLabel.verticalAlignmentMode = .center
		blockLabel.position = .zero
		scene.blockButton.addChild(blockLabel)
		scene.addChild(scene.blockButton)

		// MARK: Round Label
		scene.roundLabel = SKLabelNode(text: "Round: \(scene.currentRound)")
		scene.roundLabel.fontName = "Helvetica-Bold"
		scene.roundLabel.fontSize = 30
		scene.roundLabel.position = CGPoint(x: scene.size.width / 4,
										   y: scene.size.height - topHeight / 2)

		scene.addChild(scene.roundLabel)

		// MARK: Room Label
		scene.roomLabel = SKLabelNode(text: "Room: \(scene.currentRoom)")
		scene.roomLabel.fontName = "Helvetica-Bold"
		scene.roomLabel.fontSize = 30
		scene.roomLabel.position = CGPoint(x: scene.size.width * 0.75,
										   y: scene.size.height - topHeight / 2)
		scene.addChild(scene.roomLabel)


		// MARK: End Turn Button
		scene.endTurnButton = SKShapeNode(rectOf: topButtonSize, cornerRadius: 10)
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

	// MARK: - Game Over Screen
	func setupResultScreen() {
		// MARK: Container
		scene.gameOverScreen.position = CGPoint(x: scene.size.width / 2,
											  y: scene.size.height / 2)
		scene.gameOverScreen.zPosition = 100
		scene.gameOverScreen.isHidden = true
		scene.addChild(scene.gameOverScreen)

		// MARK: Background Panel
		let bg = SKShapeNode(rectOf: CGSize(width: 300, height: 200),
						   cornerRadius: 20)
		bg.fillColor = SKColor(white: 0.1, alpha: 0.9)
		bg.strokeColor = .white
		bg.lineWidth = 2
		scene.gameOverScreen.addChild(bg)

		// MARK: Result Label
		scene.resultLabel.fontName = "Helvetica-Bold"
		scene.resultLabel.fontSize = 40
		scene.resultLabel.position = CGPoint(x: 0, y: 50)
		scene.gameOverScreen.addChild(scene.resultLabel)

		// MARK: Action Button
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

	// MARK: - Health/Mana/Energy Updates
	func updateBarsForHero(for character: Hero) {
		if let energyBar = character.energyBar {
			updateBar(barNode: energyBar,
					 widthRatio: CGFloat(character.currentEnergy) / CGFloat(character.maxEnergy))
		}
		if let healthBar = character.healthBar {
			updateBar(barNode: healthBar,
					 widthRatio: CGFloat(character.currentHealth) / CGFloat(character.maxHealth))
		}
		if let manaBar = character.manaBar {
			updateBar(barNode: manaBar,
					 widthRatio: CGFloat(character.currentMana) / CGFloat(character.maxMana))
		}
	}

	func updateBarsForEnemy(for character: Enemy) {
		if let energyBar = character.energyBar {
			updateBar(barNode: energyBar,
					 widthRatio: CGFloat(character.currentEnergy) / CGFloat(character.maxEnergy))
		}
		if let healthBar = character.healthBar {
			updateBar(barNode: healthBar,
					 widthRatio: CGFloat(character.currentHealth) / CGFloat(character.maxHealth))
		}
		if let manaBar = character.manaBar {
			updateBar(barNode: manaBar,
					 widthRatio: CGFloat(character.currentMana) / CGFloat(character.maxMana))
		}
	}

	// MARK: - Button Visual Updates
	func updateButtonBorders() {
		let borderColor: SKColor = scene.isHeroTurn ? .white : .red
		scene.attackButton.strokeColor = borderColor
		scene.endTurnButton.strokeColor = borderColor
	}

	// MARK: - Game Over Flow
	func gameOver(isPlayerVictory: Bool) {
		scene.isUserInteractionEnabled = false

		// Update result text
		scene.resultLabel.text = isPlayerVictory ? "You Won!" : "Game Over"
		scene.resultLabel.fontColor = isPlayerVictory ? .green : .red

		// Update button text
		if let buttonLabel = scene.actionButton.children.first as? SKLabelNode {
			buttonLabel.text = isPlayerVictory ? "Enter New Room" : "Try Again"
		}

		// Show screen
		scene.gameOverScreen.isHidden = false

		// Re-enable interaction after delay
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.scene.isUserInteractionEnabled = true
		}
	}
}
