import Foundation

struct Spell {
	
	let name: String
	let spellType: SpellType  // enum: .heal, .damage, .course, .buff
	let spellSchool: SpellSchool
	let damage: Int?
	var cooldown: TimeInterval
	var isUnlocked: Bool = false
}

enum SpellType {

	case heal
	case damage
	case curse
	case buff
}

enum SpellSchool {

	case light
	case dark
	case nature
}
