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
	lazy var uiManager = GameUIManager(scene: self)
	lazy var combatManager = CombatManager(scene: self)
	lazy var characterManager = CharacterManager(scene: self)

	// MARK: Life Cycle
	override func didMove(to view: SKView) {
		backgroundColor = .black
		characterManager.setupCharacters()
		uiManager.setupGameAreas()
		uiManager.setupHeroUI()
		uiManager.setupEnemyUI()
		uiManager.setupButtons()
		uiManager.setupResultScreen()
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		let nodesAtPoint = nodes(at: location)

		for node in nodesAtPoint {
			switch node.name {
			case "attackButton": combatManager.performAttack()
			case "endTurnButton": combatManager.endCurrentTurn()
			case "actionButton":
				if uiManager.resultLabel.text == "Game Over" {
					combatManager.resetGame()
				} else {
					characterManager.spawnNewEnemy()
				}
			case "mapButton": print("MapButton pressed")
			default: break
			}
		}
	}
}
