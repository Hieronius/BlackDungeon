import SpriteKit

class GameScene: SKScene {
	override func didMove(to view: SKView) {
		// Set the background color.
		backgroundColor = .white

		// Define the size for the squares.
		let squareSize = CGSize(width: 100, height: 100)

		// --- Create the Black Square ("H") ---
		let blackSquare = SKShapeNode(rectOf: squareSize)
		blackSquare.fillColor = .black
		blackSquare.strokeColor = .clear
		// Place at the center of the scene.
		blackSquare.position = CGPoint(x: size.width / 2, y: size.height / 2)
		blackSquare.zPosition = 0

		// Create and configure the label "H" for the black square.
		let labelH = SKLabelNode(text: "H")
		labelH.fontName = "Helvetica-Bold"
		labelH.fontSize = 40
		labelH.fontColor = .white
		labelH.verticalAlignmentMode = .center
		labelH.horizontalAlignmentMode = .center
		blackSquare.addChild(labelH)

		// --- Create the Red Square ("E") ---
		let redSquare = SKShapeNode(rectOf: squareSize)
		redSquare.fillColor = .red
		redSquare.strokeColor = .clear
		// Set a slight offset so that the red square doesn’t completely obscure the black square.
		redSquare.position = CGPoint(x: size.width / 2 + 10, y: size.height / 2 + 10)
		redSquare.zPosition = 1  // Ensures it is rendered on top.

		// Create and configure the label "E" for the red square.
		let labelE = SKLabelNode(text: "E")
		labelE.fontName = "Helvetica-Bold"
		labelE.fontSize = 40
		labelE.fontColor = .white
		labelE.verticalAlignmentMode = .center
		labelE.horizontalAlignmentMode = .center
		redSquare.addChild(labelE)

		// Add both squares to the scene.
		addChild(blackSquare)
		addChild(redSquare)
	}
}
