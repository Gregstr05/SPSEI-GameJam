extends Node2D

@export var ItemScene : PackedScene
@export var MonsterDefinitions : monsterWhole

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_populate_grid()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _populate_grid():
	_add_parts(MonsterDefinitions.head)
	_add_parts(MonsterDefinitions.arms)
	_add_parts(MonsterDefinitions.body)
	_add_parts(MonsterDefinitions.legs)
	_add_parts(MonsterDefinitions.tail)

func _add_parts(part :Array[monsterPart]):
	for i in part:
		var ItemSlot = ItemScene.instantiate()
		ItemSlot.monsterPartInstance = i
		ItemSlot.custom_minimum_size = Vector2(102.4, 102.4)
		%GridContainer.add_child(ItemSlot)

func _parts_updated():
	var check = 0
	var receptacles = get_tree().get_nodes_in_group("Receptacle")
	for receptacle in receptacles:
		if typeof(receptacle.monsterPartInstance) == TYPE_NIL:
			check -= 1
	print(check)
	if check < 0:
		%Reanimate.disabled = true
	else:
		%Reanimate.disabled = false
	pass


func _on_reanimate_pressed() -> void:
	var receptacles = get_tree().get_nodes_in_group("Receptacle")
	for receptacle in receptacles:
		MonsterGlobal.MonsterAsortedParts.append(receptacle.monsterPartInstance)
	
	MonsterGlobal._asign_parts()
	get_tree().get_first_node_in_group("LevelLoader").load_level_scene("res://scenes/Arena/Arena.tscn")
	pass # Replace with function body.
