extends Node

var Enemy : Array[monsterEnemy]
var ActiveEnemy :Dictionary
var EnemyIndex : int = 0

func _asign_parts():
	var EnemyParts = Enemy[EnemyIndex]
	ActiveEnemy["Head"] = EnemyParts.head
	ActiveEnemy["Arms"] = EnemyParts.arms
	ActiveEnemy["Body"] = EnemyParts.body
	ActiveEnemy["Legs"] = EnemyParts.legs
	ActiveEnemy["Tail"] = EnemyParts.tail
