import SpriteKit

// MARK: - Main GameScene Class

class GameScene: SKScene {
	// Game state
	var currentRound: Int = 1
	var isHeroTurn: Bool = true

	// Characters
	var hero: Hero!
	var enemy: Enemy!

	// UI Elements
	var attackButton: SKShapeNode!
	var endTurnButton: SKShapeNode!
	var roundLabel: SKLabelNode!
}

// MARK: - Game Logic Layer

extension GameScene {

	// MARK: - Character Management
	func setupCharacters() {
		hero = Hero(name: "Hieronius",
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

		enemy = Enemy(type: .skeleton,
					  maxHealth: 50,
					  currentHealth: 50,
					  maxMana: 50,
					  currentMana: 50,
					  maxDamage: 15,
					  minDamage: 10,
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

	// MARK: - Combat System

	func performAttack() {

		if isHeroTurn {
			if hero.currentEnergy >= 1 {
				hero.currentEnergy -= 1
				updateBarsForHero(for: hero)

				let avgDamage = (CGFloat(hero.maxDamage) + CGFloat(hero.minDamage)) / 2
				let damageDealt = max(0, avgDamage - CGFloat(enemy.armor))
				enemy.currentHealth = max(0, enemy.currentHealth - Int(damageDealt))
				updateBarsForEnemy(for: enemy)
			}
		} else {
			if enemy.currentEnergy >= 1 {
				enemy.currentEnergy -= 1
				updateBarsForEnemy(for: enemy)

				let avgDamage = (CGFloat(enemy.maxDamage) + CGFloat(enemy.minDamage)) / 2
				let damageDealt = max(0, avgDamage - CGFloat(hero.armor))
				hero.currentHealth = max(0, hero.currentHealth - Int(damageDealt))
				updateBarsForHero(for: hero)
			}
		}
	}

	func endCurrentTurn() {

		if isHeroTurn {
			isHeroTurn = false
			enemy.currentEnergy = 5
			updateBarsForEnemy(for: enemy)
		} else {
			isHeroTurn = true
			hero.currentEnergy = 5
			currentRound += 1
			roundLabel.text = "Round: \(currentRound)"
			updateBarsForHero(for: hero)
		}
		updateButtonBorders()
	}

	func updateButtonBorders() {
		let borderColor: SKColor = isHeroTurn ? .white : .red
		attackButton.strokeColor = borderColor
		endTurnButton.strokeColor = borderColor
	}

	// MARK: - Health/Mana/Energy Bar Updates

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
}

// MARK: - Visual Representation Layer

extension GameScene {

	// MARK: - UI Setup

	override func didMove(to view: SKView) {
		backgroundColor = .black
		setupCharacters()
		setupGameAreas()
		setupHeroUI()
		setupEnemyUI()
		setupButtons()
	}

	private func setupGameAreas() {
		let topHeight = size.height * 0.2
		let middleHeight = size.height * 0.5
		let bottomHeight = size.height * 0.3

		// Top area (round counter)
		let topArea = SKShapeNode(rect: CGRect(x: 0, y: size.height - topHeight, width: size.width, height: topHeight))
		topArea.strokeColor = .white
		topArea.lineWidth = 2
		addChild(topArea)

		// Middle area (characters)
		let middleArea = SKShapeNode(rect: CGRect(x: 0, y: bottomHeight, width: size.width, height: middleHeight))
		middleArea.strokeColor = .white
		middleArea.lineWidth = 2
		addChild(middleArea)

		// Bottom area (buttons)
		let bottomArea = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: bottomHeight))
		bottomArea.strokeColor = .white
		bottomArea.lineWidth = 2
		addChild(bottomArea)
	}

	private func setupHeroUI() {
		let squareSize = CGSize(width: 100, height: 100)
		let barWidth: CGFloat = 120
		let barHeight: CGFloat = 10
		let barOffset: CGFloat = 70

		let heroPosition = CGPoint(x: size.width * 0.33, y: size.height * 0.3 + size.height * 0.5 / 2)

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
		let heroEnergyBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
		heroEnergyBg.fillColor = .darkGray
		heroEnergyBg.strokeColor = .clear
		heroEnergyBg.position = CGPoint(x: heroPosition.x - barWidth / 2, y: heroPosition.y + barOffset)

		let heroEnergy = createBarNode(width: barWidth, height: barHeight, color: .orange)
		heroEnergy.position = CGPoint(x: heroPosition.x - barWidth / 2, y: heroPosition.y + barOffset + 15)

		// Health bar
		let heroHealthBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
		heroHealthBg.fillColor = .darkGray
		heroHealthBg.strokeColor = .clear
		heroHealthBg.position = CGPoint(x: heroPosition.x - barWidth / 2, y: heroPosition.y + barOffset)

		let heroHealth = createBarNode(width: barWidth, height: barHeight, color: .green)
		heroHealth.position = CGPoint(x: heroPosition.x - barWidth / 2, y: heroPosition.y + barOffset)

		// Mana bar
		let heroManaBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
		heroManaBg.fillColor = .darkGray
		heroManaBg.strokeColor = .clear
		heroManaBg.position = CGPoint(x: heroPosition.x - barWidth / 2, y: heroPosition.y + barOffset - 15)

		let heroMana = createBarNode(width: barWidth, height: barHeight, color: .blue)
		heroMana.position = CGPoint(x: heroPosition.x - barWidth / 2, y: heroPosition.y + barOffset - 15)

		hero.spriteNode = blackSquare
		hero.healthBar = heroHealth
		hero.manaBar = heroMana
		hero.energyBar = heroEnergy

		addChild(blackSquare)
		addChild(heroHealthBg)
		addChild(heroHealth)
		addChild(heroManaBg)
		addChild(heroMana)
		addChild(heroEnergy)
	}

	private func setupEnemyUI() {
		let squareSize = CGSize(width: 100, height: 100)
		let barWidth: CGFloat = 120
		let barHeight: CGFloat = 10
		let barOffset: CGFloat = 70

		let enemyPosition = CGPoint(x: size.width * 0.66, y: size.height * 0.3 + size.height * 0.5 / 2)

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
		let enemyEnergyBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
		enemyEnergyBg.fillColor = .darkGray
		enemyEnergyBg.strokeColor = .clear
		enemyEnergyBg.position = CGPoint(x: enemyPosition.x - barWidth / 2, y: enemyPosition.y + barOffset)

		let enemyEnergy = createBarNode(width: barWidth, height: barHeight, color: .orange)
		enemyEnergy.position = CGPoint(x: enemyPosition.x - barWidth / 2, y: enemyPosition.y + barOffset + 15)

		// Health bar
		let enemyHealthBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
		enemyHealthBg.fillColor = .darkGray
		enemyHealthBg.strokeColor = .clear
		enemyHealthBg.position = CGPoint(x: enemyPosition.x - barWidth / 2, y: enemyPosition.y + barOffset)

		let enemyHealth = createBarNode(width: barWidth, height: barHeight, color: .green)
		enemyHealth.position = CGPoint(x: enemyPosition.x - barWidth / 2, y: enemyPosition.y + barOffset)

		// Mana bar
		let enemyManaBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
		enemyManaBg.fillColor = .darkGray
		enemyManaBg.strokeColor = .clear
		enemyManaBg.position = CGPoint(x: enemyPosition.x - barWidth / 2, y: enemyPosition.y + barOffset - 15)

		let enemyMana = createBarNode(width: barWidth, height: barHeight, color: .blue)
		enemyMana.position = CGPoint(x: enemyPosition.x - barWidth / 2, y: enemyPosition.y + barOffset - 15)

		enemy.spriteNode = redSquare
		enemy.healthBar = enemyHealth
		enemy.manaBar = enemyMana
		enemy.energyBar = enemyEnergy

		addChild(redSquare)
		addChild(enemyHealthBg)
		addChild(enemyHealth)
		addChild(enemyManaBg)
		addChild(enemyMana)
		addChild(enemyEnergy)
	}

	private func setupButtons() {

		let bottomHeight = size.height * 0.3
		let buttonSize = CGSize(width: 200, height: 60)

		// Attack Button (now with border)
		attackButton = SKShapeNode(rectOf: buttonSize, cornerRadius: 10)
		attackButton.position = CGPoint(x: size.width / 2, y: bottomHeight / 2 + 40)
		attackButton.fillColor = .clear
		attackButton.strokeColor = isHeroTurn ? .white : .red
		attackButton.lineWidth = 3
		attackButton.name = "attackButton"

		let attackLabel = SKLabelNode(text: "Attack")
		attackLabel.fontName = "Helvetica-Bold"
		attackLabel.fontSize = 30
		attackLabel.fontColor = .white
		attackLabel.verticalAlignmentMode = .center
		attackLabel.position = CGPoint(x: 0, y: 0)
		attackButton.addChild(attackLabel)

		// Round counter
		roundLabel = SKLabelNode(text: "Round: \(currentRound)")
		roundLabel.fontName = "Helvetica-Bold"
		roundLabel.fontSize = 30
		roundLabel.fontColor = .white
		roundLabel.position = CGPoint(x: size.width / 2, y: size.height - (size.height * 0.2) / 2)

		// End Turn Button (now positioned under round counter)
		endTurnButton = SKShapeNode(rectOf: buttonSize, cornerRadius: 10)
		endTurnButton.position = CGPoint(x: size.width / 2, y: roundLabel.position.y - 50) // 50 points below round counter
		endTurnButton.fillColor = .clear
		endTurnButton.strokeColor = isHeroTurn ? .white : .red
		endTurnButton.lineWidth = 3
		endTurnButton.name = "endTurnButton"

		let endTurnLabel = SKLabelNode(text: "End Turn")
		endTurnLabel.fontName = "Helvetica-Bold"
		endTurnLabel.fontSize = 30
		endTurnLabel.fontColor = .white
		endTurnLabel.verticalAlignmentMode = .center
		endTurnLabel.position = CGPoint(x: 0, y: 0)
		endTurnButton.addChild(endTurnLabel)

		addChild(attackButton)
		addChild(roundLabel)
		addChild(endTurnButton)
	}

	// MARK: - UI Utilities

	func createBarNode(width: CGFloat, height: CGFloat, color: SKColor) -> SKShapeNode {
		let path = CGMutablePath()
		path.addRect(CGRect(x: 0, y: 0, width: width, height: height))
		let bar = SKShapeNode(path: path)
		bar.fillColor = color
		bar.strokeColor = .clear
		bar.lineWidth = 0
		return bar
	}

	// MARK: - Touch Handling

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
			guard let touch = touches.first else { return }
			let location = touch.location(in: self)
			let nodesAtPoint = self.nodes(at: location)

			for node in nodesAtPoint {
				if node.name == "attackButton" || (node.parent?.name == "attackButton") {
					performAttack()
				} else if node.name == "endTurnButton" || (node.parent?.name == "endTurnButton") {
					endCurrentTurn()
				}
			}
		}
}
