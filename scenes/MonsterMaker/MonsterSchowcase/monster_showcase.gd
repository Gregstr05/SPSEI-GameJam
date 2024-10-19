extends Node2D

@export var Null_part :monsterPart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_showcase()
	pass # Replace with function body.

func _update_showcase():
	print("update showcase")
	var receptacles = get_tree().get_nodes_in_group("Receptacle")
	MonsterGlobal.MonsterAsortedParts.clear()
	for receptacle in receptacles:
		if typeof(receptacle.monsterPartInstance) != TYPE_NIL:
			MonsterGlobal.MonsterAsortedParts.append(receptacle.monsterPartInstance)
	
	MonsterGlobal._asign_parts()

	if typeof(MonsterGlobal.PlayerMonster["Head"]) != TYPE_INT:
		$MonsterScene.Monster["Head"] = MonsterGlobal.PlayerMonster["Head"]
		print("Adding head")


	if typeof(MonsterGlobal.PlayerMonster["Arms"]) != TYPE_INT:
		$MonsterScene.Monster["Arms"] = MonsterGlobal.PlayerMonster["Arms"]

	
	if typeof(MonsterGlobal.PlayerMonster["Body"]) != TYPE_INT:
		$MonsterScene.Monster["Body"]  = MonsterGlobal.PlayerMonster["Body"]

	
	if typeof(MonsterGlobal.PlayerMonster["Legs"]) != TYPE_INT:
		$MonsterScene.Monster["Legs"] = MonsterGlobal.PlayerMonster["Legs"]

	
	if typeof(MonsterGlobal.PlayerMonster["Tail"]) != TYPE_INT:
		$MonsterScene.Monster["Tail"] = MonsterGlobal.PlayerMonster["Tail"]
	
	print("Draw showcase")
	$MonsterScene._draw_monster()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
