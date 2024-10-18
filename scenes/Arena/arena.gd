extends Node2D

var PlayerMonster :Dictionary = {"Head": 0, "Arms": 0, "Body": 0, "Legs": 0, "Tail": 0}
var EnemyMonster :Dictionary = {"Head": 0, "Arms": 0, "Body": 0, "Legs": 0, "Tail": 0}

signal level_won
signal level_lost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _load_parts():
	
	pass


func _on_primary_pressed() -> void:
	pass # Replace with function body.


func _on_secondary_pressed() -> void:
	pass # Replace with function body.


func _on_heal_pressed() -> void:
	pass # Replace with function body.


func _on_enemy_spawn_died() -> void:
	level_won.emit()
	pass # Replace with function body.


func _on_player_spawn_died() -> void:
	level_lost.emit()
	pass # Replace with function body.
