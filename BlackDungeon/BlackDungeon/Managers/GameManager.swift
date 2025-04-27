import SpriteKit

/// GameManager - Manages rooms, rounds, and turn state
class GameManager {
	private unowned let scene: GameScene

	init(scene: GameScene) {
		self.scene = scene
	}

	func setupRoom() {
		scene.currentRoom += 1
		scene.currentRound = 1
		scene.isHeroTurn = true
		scene.spriteManager.roomLabel.text = "Room: \(scene.currentRoom)"
		scene.spriteManager.roundLabel.text = "Round: \(scene.currentRound)"
	}

	func nextRound() {
		scene.currentRound += 1
		scene.spriteManager.roundLabel.text = "Round: \(scene.currentRound)"
	}

	func resetRounds() {
		scene.currentRound = 1
		scene.spriteManager.roundLabel.text = "Round: \(scene.currentRound)"
	}

	func toggleTurn() {
		scene.isHeroTurn.toggle()
	}
}
