import SpriteKit

enum EnemyType {

	case skeleton
	case skeletonGuard
	case skeletonArcher
	case skeletonMage
	case skeletonLord
	case skeletonLich
	case ghost
	case spider
	case rat
}

class Enemy {

	let type: EnemyType

	var maxHealth: Int
	var currentHealth: Int

	var maxMana: Int
	var currentMana: Int

	var maxDamage: Int
	var minDamage: Int

	var maxEnergy: Int
    var currentEnergy: Int

	var blockChance: Int
	var criticalRate: Int

	var armor: Int

	var skills: [Skill]

	var spells: [Spell]

	var weaponType: WeaponType

	var inventory: [Item]

	// Link to sprite and bars
	weak var spriteNode: SKNode?
	weak var healthBar: SKShapeNode?
	weak var manaBar: SKShapeNode?
	weak var energyBar: SKShapeNode?

	init(
		type: EnemyType,
		 maxHealth: Int,
		 currentHealth: Int,
		 maxMana: Int,
		 currentMana: Int,
		 maxDamage: Int,
		 minDamage: Int,
		 maxEnergy: Int,
		 currentEnergy: Int,
		 blockChance: Int,
		 criticalRate: Int,
		 armor: Int,
		 skills: [Skill],
		 spells: [Spell],
		 weaponType: WeaponType,
		 inventory: [Item]
	) {
		self.type = type
		self.maxHealth = maxHealth
		self.currentHealth = currentHealth
		self.maxMana = maxMana
		self.currentMana = currentMana
		self.maxDamage = maxDamage
		self.minDamage = minDamage
		self.maxEnergy = maxEnergy
		self.currentEnergy = currentEnergy
		self.blockChance = blockChance
		self.criticalRate = criticalRate
		self.armor = armor
		self.skills = skills
		self.spells = spells
		self.weaponType = weaponType
		self.inventory = inventory
	}
}
