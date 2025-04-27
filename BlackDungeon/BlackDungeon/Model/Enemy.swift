// Enemy.swift
import SpriteKit

class Enemy: Character {

	let name: String
	let maxHealth: Int
	var currentHealth: Int
	let maxMana: Int
	var currentMana: Int
	let maxEnergy: Int
	var currentEnergy: Int
	var maxDamage: Int
	var minDamage: Int
	let skills: [Skill]
	let spells: [Spell]

	// Sprite references
	weak var spriteNode: SKNode?
	weak var healthBar: SKShapeNode?
	weak var manaBar: SKShapeNode?
	weak var energyBar: SKShapeNode?

	init(name: String,
		 maxHealth: Int,
		 currentHealth: Int,
		 maxMana: Int,
		 currentMana: Int,
		 maxEnergy: Int,
		 currentEnergy: Int,
		 maxDamage: Int,
		 minDamage: Int,
		 skills: [Skill],
		 spells: [Spell]) {
		self.name = name
		self.maxHealth = maxHealth
		self.currentHealth = currentHealth
		self.maxMana = maxMana
		self.currentMana = currentMana
		self.maxEnergy = maxEnergy
		self.currentEnergy = currentEnergy
		self.skills = skills
		self.spells = spells
		self.maxDamage = maxDamage
		self.minDamage = minDamage
	}
}
