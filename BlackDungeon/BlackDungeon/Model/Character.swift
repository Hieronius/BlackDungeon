import Foundation

protocol Character {
	var name: String { get }
	var maxHealth: Int { get }
	var currentHealth: Int { get set }
	var maxMana: Int { get }
	var currentMana: Int { get set }
	var maxEnergy: Int { get }
	var currentEnergy: Int { get set }
	var maxDamage: Int { get set }
	var minDamage: Int { get set }
	var skills: [Skill] { get }
	var spells: [Spell] { get }
}
