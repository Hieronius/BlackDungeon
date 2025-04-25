import SpriteKit

class GameScene: SKScene {

	var hero: Hero!
	var enemy: Enemy!
	var attackButton: SKLabelNode!
	var roundLabel: SKLabelNode!
	var currentRound: Int = 1
	var isHeroTurn: Bool = true  // To track whose turn it is

	override func didMove(to view: SKView) {
		backgroundColor = .black

		hero = Hero(name: "Hieronius", maxHealth: 100, currentHealth: 100, maxMana: 100, currentMana: 100, maxDamage: 15, minDamage: 10, blockChance: 10, criticalRate: 10, armor: 10, skills: [], spells: [], weaponType: .twoHandedSword, inventory: [])

		enemy = Enemy(type: .skeleton, maxHealth: 50, currentHealth: 50, maxMana: 50, currentMana: 50, maxDamage: 15, minDamage: 10, blockChance: 5, criticalRate: 5, armor: 5, skills: [], spells: [], weaponType: .sword, inventory: [])

		let topHeight = size.height * 0.2
		let middleHeight = size.height * 0.5
		let bottomHeight = size.height * 0.3

		let topArea = SKShapeNode(rect: CGRect(x: 0, y: size.height - topHeight, width: size.width, height: topHeight))
		topArea.strokeColor = .white
		topArea.lineWidth = 2
		addChild(topArea)

		let middleArea = SKShapeNode(rect: CGRect(x: 0, y: bottomHeight, width: size.width, height: middleHeight))
		middleArea.strokeColor = .white
		middleArea.lineWidth = 2
		addChild(middleArea)

		let squareSize = CGSize(width: 100, height: 100)
		let barWidth: CGFloat = 120
		let barHeight: CGFloat = 10
		let barOffset: CGFloat = 70

		let heroPosition = CGPoint(x: size.width * 0.33, y: bottomHeight + middleHeight / 2)
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

		let heroHealthBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
		heroHealthBg.fillColor = .darkGray
		heroHealthBg.strokeColor = .clear
		heroHealthBg.position = CGPoint(x: heroPosition.x - barWidth / 2, y: heroPosition.y + barOffset)

		let heroHealth = createBarNode(width: barWidth, height: barHeight, color: .green)
		heroHealth.position = CGPoint(x: heroPosition.x - barWidth / 2, y: heroPosition.y + barOffset)

		let heroManaBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
		heroManaBg.fillColor = .darkGray
		heroManaBg.strokeColor = .clear
		heroManaBg.position = CGPoint(x: heroPosition.x - barWidth / 2, y: heroPosition.y + barOffset - 15)

		let heroMana = createBarNode(width: barWidth, height: barHeight, color: .blue)
		heroMana.position = CGPoint(x: heroPosition.x - barWidth / 2, y: heroPosition.y + barOffset - 15)

		let enemyPosition = CGPoint(x: size.width * 0.66, y: bottomHeight + middleHeight / 2)
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

		let enemyHealthBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
		enemyHealthBg.fillColor = .darkGray
		enemyHealthBg.strokeColor = .clear
		enemyHealthBg.position = CGPoint(x: enemyPosition.x - barWidth / 2, y: enemyPosition.y + barOffset)

		let enemyHealth = createBarNode(width: barWidth, height: barHeight, color: .green)
		enemyHealth.position = CGPoint(x: enemyPosition.x - barWidth / 2, y: enemyPosition.y + barOffset)

		let enemyManaBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight))
		enemyManaBg.fillColor = .darkGray
		enemyManaBg.strokeColor = .clear
		enemyManaBg.position = CGPoint(x: enemyPosition.x - barWidth / 2, y: enemyPosition.y + barOffset - 15)

		let enemyMana = createBarNode(width: barWidth, height: barHeight, color: .blue)
		enemyMana.position = CGPoint(x: enemyPosition.x - barWidth / 2, y: enemyPosition.y + barOffset - 15)

		hero.spriteNode = blackSquare
		enemy.spriteNode = redSquare

		hero.healthBar = heroHealth
		hero.manaBar = heroMana

		enemy.healthBar = enemyHealth
		enemy.manaBar = enemyMana

		updateBarsForHero(for: hero)
		updateBarsForEnemy(for: enemy)

		addChild(blackSquare)
		addChild(redSquare)
		addChild(heroHealthBg)
		addChild(heroHealth)
		addChild(heroManaBg)
		addChild(heroMana)
		addChild(enemyHealthBg)
		addChild(enemyHealth)
		addChild(enemyManaBg)
		addChild(enemyMana)

		// Create the Attack Button at the bottom
		attackButton = SKLabelNode(text: "Attack")
		attackButton.fontName = "Helvetica-Bold"
		attackButton.fontSize = 40
		attackButton.fontColor = .white
		attackButton.position = CGPoint(x: size.width / 2, y: bottomHeight / 2)
		attackButton.name = "attackButton"
		addChild(attackButton)

		// Create the Round Counter at the top
		roundLabel = SKLabelNode(text: "Round: \(currentRound)")
		roundLabel.fontName = "Helvetica-Bold"
		roundLabel.fontSize = 30
		roundLabel.fontColor = .white
		roundLabel.position = CGPoint(x: size.width / 2, y: size.height - topHeight / 2)
		addChild(roundLabel)

		var roundLabel: SKLabelNode!
		var currentRound: Int = 1
		var isHeroTurn: Bool = true  // To track whose turn it is

		let bottomArea = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: bottomHeight))
		bottomArea.strokeColor = .white
		bottomArea.lineWidth = 2
		addChild(bottomArea)
	}

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
		if let healthBar = character.healthBar {
			let ratio = CGFloat(character.currentHealth) / CGFloat(character.maxHealth)
			updateBar(barNode: healthBar, widthRatio: ratio)
		}

		if let manaBar = character.manaBar {
			let ratio = CGFloat(character.currentMana) / CGFloat(character.maxMana)
			updateBar(barNode: manaBar, widthRatio: ratio)
		}
	}

	// Handle touch input
		override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
			for touch in touches {
				let location = touch.location(in: self)
				let nodesAtPoint = self.nodes(at: location)

				if nodesAtPoint.contains(attackButton) {
					performHeroAttack()
				}
			}
		}

	// Hero's Attack
		func performHeroAttack() {
			if isHeroTurn {
				// Calculate the damage
				let avgDamage = (CGFloat(hero.maxDamage) + CGFloat(hero.minDamage)) / 2
				let damageDealt = max(0, avgDamage - CGFloat(enemy.armor))

				print("enemy got \(damageDealt) amount of damage")

				// Apply damage to enemy
				enemy.currentHealth = max(0, enemy.currentHealth - Int(damageDealt))

				// Update enemy health bar
				updateBarsForEnemy(for: enemy)

				// Switch to enemy's turn
				isHeroTurn = false

				// Perform enemy's attack after a short delay
				run(SKAction.wait(forDuration: 1.0)) {
					self.performEnemyAttack()
				}
			}
		}

	// Enemy's Attack
		func performEnemyAttack() {
			if !isHeroTurn {
				// Calculate the damage
				let avgDamage = (CGFloat(enemy.maxDamage) + CGFloat(enemy.minDamage)) / 2
				let damageDealt = max(0, avgDamage - CGFloat(hero.armor))
				print("hero suffered \(damageDealt)")

				// Apply damage to hero
				hero.currentHealth = max(0, hero.currentHealth - Int(damageDealt))

				// Update hero health bar
				updateBarsForHero(for: hero)

				// Switch back to hero's turn
				isHeroTurn = true

				// Increment the round counter
				currentRound += 1
				roundLabel.text = "Round: \(currentRound)"
			}
		}
}
