extends Resource

class_name monsterPart

enum types {
	Head,
	Arms,
	Body,
	Legs,
	Tail
}

@export var type : types 
@export var partName : String = ""
@export var description : String = ""
@export var texture : Texture2D
@export var icon : Texture2D
@export var stats : Dictionary = {
	"damagePrimary": 				0,
	"damageSecondary":				0,
	"secondaryCooldown":			0,
	"HP": 							0,
	"heal": 						0,
	"healCooldown": 				0,
}
