import UIKit
import SpriteKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene,
			   willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else { return }

		// Create the UIWindow using the windowScene and set it up with an SKView.
		let window = UIWindow(windowScene: windowScene)
		let skView = SKView(frame: windowScene.coordinateSpace.bounds)

		// Instantiate your custom scene with the same size as the SKView.
		let scene = GameScene(size: skView.bounds.size)
		scene.scaleMode = .aspectFill

		// Present the scene.
		skView.presentScene(scene)

		// Configure a basic view controller to host the SKView.
		let viewController = GameViewController()
		viewController.view = skView
		window.rootViewController = viewController
		self.window = window
		window.makeKeyAndVisible()
	}
}
