import Foundation

struct Item {

	let name: String
	let itemType: ItemType
	var stack: Int
}

enum ItemType {

	case weapon
	case armor
	case consumbles
	case scroll
}
