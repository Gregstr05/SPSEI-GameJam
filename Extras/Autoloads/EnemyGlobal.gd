extends Node

var Enemy : Array[monsterEnemyResource]
var ActiveEnemy :Dictionary
var ActiveEnemyName :String
var EnemyIndex : int = 0

func _asign_parts():
	var EnemyParts = Enemy[EnemyIndex]
	ActiveEnemyName = EnemyParts.Name
	ActiveEnemy["Head"] = EnemyParts.head
	ActiveEnemy["Arms"] = EnemyParts.arms
	ActiveEnemy["Body"] = EnemyParts.body
	ActiveEnemy["Legs"] = EnemyParts.legs
	ActiveEnemy["Tail"] = EnemyParts.tail
