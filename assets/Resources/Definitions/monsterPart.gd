extends Resource

class_name monsterPart

@export var partName : String = ""
@export var description : String = ""
@export var texture : ImageTexture
@export var icon : ImageTexture
@export var stats : Dictionary = {
	"damagePrimary": 				0,
	"damageSecondary":				0,
	"secondaryCooldown":			0,
	"HP": 							0,
	"heal": 						0,
	"healCooldown": 				0,
}
