extends Node2D

var Monster :Dictionary = {"Head": 0, "Arms": 0, "Body": 0, "Legs": 0, "Tail": 0}

var HP :int = 100

signal died
signal PrimaryAttack(damage :int)
signal SecondaryAttack(damage :int)
signal Heal(amount :int)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Head.texture = Monster["Head"].texture
	$Arms.texture = Monster["Arms"].texture
	$Body.texture = Monster["Body"].texture
	$Legs.texture = Monster["Legs"].texture
	$Tail.texture = Monster["Tail"].texture
	
	pass # Replace with function body.

func _make_enemy():
	for child in get_children():
		child.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
