extends Node

var MonsterAsortedParts : Array[monsterPart]
var PlayerMonster :Dictionary = {"Head": 0, "Arms": 0, "Body": 0, "Legs": 0, "Tail": 0}

func _asign_parts():
	for part in MonsterAsortedParts:
		print(part.type)
		match part.type:
			0:
				PlayerMonster["Head"] = part
			1:
				PlayerMonster["Arms"] = part
			2:
				PlayerMonster["Body"] = part
			3:
				PlayerMonster["Legs"] = part
			4:
				PlayerMonster["Tail"] = part
