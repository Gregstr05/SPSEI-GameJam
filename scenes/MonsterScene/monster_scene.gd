extends Node2D

@export var Null_part :Texture2D

var Monster :Dictionary = {"Head": 0, "Arms": 0, "Body": 0, "Legs": 0, "Tail": 0}

var HP :int = 100
var SecondaryCooldown :int = 2
var HealCooldown :int = 2

signal died
signal PrimaryAttack(damage :int)
signal SecondaryAttack(damage :int)
signal Heal(amount :int)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Head.texture = Monster["Head"].texture if typeof(Monster["Head"]) != TYPE_NIL else Null_part
	$Arms.texture = Monster["Arms"].texture if Monster["Arms"] != TYPE_NIL else Null_part
	$Body.texture = Monster["Body"].texture if Monster["Body"] != TYPE_NIL else Null_part
	$Legs.texture = Monster["Legs"].texture if Monster["Legs"] != TYPE_NIL else Null_part
	$Tail.texture = Monster["Tail"].texture if Monster["Tail"] != TYPE_NIL else Null_part
	
	print("Health: %d" % _calculate_health())
	
	pass # Replace with function body.

func _calculate_health() -> int:
	for part in Monster:
		HP += Monster[part].stats["HP"]
	return HP

func _calculate_secondary_cooldown():
	for part in Monster:
		SecondaryCooldown += Monster[part].stats["secondaryCooldown"]
	return SecondaryCooldown

func _calculate_heal_cooldwon():
	for part in Monster:
		HealCooldown += Monster[part].stats["healCooldown"]
	return HealCooldown

func _make_enemy():
	for child in get_children():
		child.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
