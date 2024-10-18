extends Resource

class_name monsterPart

@export var partName : String = ""
@export var texture : ImageTexture
@export var icon : ImageTexture
@export var stats : Dictionary = {
	"damagePrimary": 				0,
	"damageSecondary":				0,
	"damageSecondaryRounds":		0,
	"HP": 							0,
	"heal": 						0,
	"healRounds": 					0,
}
