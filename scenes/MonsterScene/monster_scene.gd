extends Node2D

@export var Null_part :Texture2D

var Monster :Dictionary = {"Head": 0, "Arms": 0, "Body": 0, "Legs": 0, "Tail": 0}

var HP :int = 200
var SecondaryCooldown :int = 2
var HealCooldown :int = 2

signal died
signal PrimaryAttack(damage :int)
signal SecondaryAttack(damage :int)
signal Heal(amount :int)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_draw_monster()
	
	print("Health: %d" % _calculate_health())
	
	pass # Replace with function body.

func _draw_monster():
	if typeof(Monster["Head"]) != TYPE_INT:
		$Head.texture = Monster["Head"].texture
	else: $Head.texture = Null_part
	
	if typeof(Monster["Arms"]) != TYPE_INT:
		$Arms.texture = Monster["Arms"].texture
	else: $Arms.texture = Null_part
	
	if typeof(Monster["Body"]) != TYPE_INT:
		$Body.texture = Monster["Body"].texture
	else: $Body.texture = Null_part
	
	if typeof(Monster["Legs"]) != TYPE_INT:
		$Legs.texture = Monster["Legs"].texture
	else: $Legs.texture = Null_part
	
	if typeof(Monster["Tail"]) != TYPE_INT:
		$Tail.texture = Monster["Tail"].texture
	else: $Tail.texture = Null_part

func _calculate_health() -> int:
	for part in Monster:
		if typeof(Monster[part]) != TYPE_INT:
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
