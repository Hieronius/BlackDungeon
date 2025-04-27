// GameScene.swift
import SpriteKit

/// GameScene - Core scene with properties and touch handling
class GameScene: SKScene {
	// Game state
	var currentRound: Int = 1
	var currentRoom: Int = 1
	var isHeroTurn: Bool = true

	// Characters
	var hero: Hero!
	var enemy: Enemy!

	// Managers
	lazy var spriteManager = SpriteManager(scene: self)
	lazy var combatManager = CombatManager(scene: self)
	lazy var characterManager = CharacterManager(scene: self)
	lazy var updateManager = UpdateManager(scene: self)
	lazy var gameManager = GameManager(scene: self)

	// MARK: Life Cycle
	override func didMove(to view: SKView) {
		backgroundColor = .black
		spriteManager.setupGameAreas()
		spriteManager.setupButtons()
		characterManager.setupCharacters()
		spriteManager.setupHeroUI()
		spriteManager.setupEnemyUI()
		spriteManager.setupResultScreen()
	    updateManager.refreshAllBars()
		print("YOU MORON")
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		let nodesAtPoint = nodes(at: location)

		for node in nodesAtPoint {
			switch node.name {
			case "attackButton": combatManager.performAttack()
			case "endTurnButton":
				combatManager.endCurrentTurn()
				updateManager.updateButtonBorders()
			case "actionButton":
				if spriteManager.resultLabel.text == "Game Over" {
					combatManager.resetGame()
				} else {
					characterManager.spawnEnemy()
				}
			case "mapButton": print("MapButton pressed")
			default: break
			}
		}
	}
}
