import Foundation

struct Skill {
	let name: String
	let type: SkillType  // enum: .attack, .defense, .block, .buff
	let damage: Int?
	var cooldown: TimeInterval
	var isUnlocked: Bool = false
}

enum SkillType {

	case attack
	case defense
	case block
}

