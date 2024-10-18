extends Node2D

var PlayerMonster :Dictionary
var EnemyMonster :Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayerSpawn.Monster = PlayerMonster
	$EnemySpawn.Monster = EnemyMonster
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _load_parts():
	
	pass
