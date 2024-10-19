extends Node2D

@export var ItemScene : PackedScene
@export var MonsterDefinitions : monsterWhole

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MonsterGlobal.PlayerMonster = {"Head": 0, "Arms": 0, "Body": 0, "Legs": 0, "Tail": 0}
	_populate_grid()
	$CanvasLayer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/Part.text = ""
	%PartDescription.text = "Health: 
Primary Damage: 
Secondary Damage: 
Secondary Cooldown: 
Heal: 
Heal Cooldown: "

	%MonsterDescription.text = "Health: 200
Primary Damage: 10
Secondary Damage: 20
Secondary Cooldown: 2
Heal: 10"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _recieve_part_data(data :monsterPart):
	print(data.stats)
	_show_data(data)
	pass

func _show_data(data :monsterPart):
	$CanvasLayer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/Part.text = "%s:" % data.partName
	%PartDescription.text = "Health: %s
Primary Damage: %s
Secondary Damage: %s
Secondary Cooldown: %s
Heal: %s
Heal Cooldown: %s" % [data.stats["HP"], data.stats["damagePrimary"], data.stats["damageSecondary"], data.stats["secondaryCooldown"], data.stats["heal"], data.stats["healCooldown"]]

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
		ItemSlot.sendData.connect(_recieve_part_data)
		%GridContainer.add_child(ItemSlot)

func _parts_updated():
	var check = 0
	var receptacles = get_tree().get_nodes_in_group("Receptacle")
	for receptacle in receptacles:
		if typeof(receptacle.monsterPartInstance) == TYPE_NIL:
			check -= 1
	print(check)
	_show_monster_stats()
	if check < 0:
		%Reanimate.disabled = true
	else:
		%Reanimate.disabled = false
	pass

func _show_monster_stats():
	var health = 200
	var primary = 10
	var secondary = 20
	var secondaryCooldown = 2
	var heal = 10
	var healCooldown = 2
	var receptacles = get_tree().get_nodes_in_group("Receptacle")
	for receptacle in receptacles:
		if typeof(receptacle.monsterPartInstance) != TYPE_NIL:
			heal += receptacle.monsterPartInstance.stats["heal"]
		if typeof(receptacle.monsterPartInstance) != TYPE_NIL:
			health += receptacle.monsterPartInstance.stats["HP"]
		if typeof(receptacle.monsterPartInstance) != TYPE_NIL:
			primary += receptacle.monsterPartInstance.stats["damagePrimary"]
		if typeof(receptacle.monsterPartInstance) != TYPE_NIL:
			secondary += receptacle.monsterPartInstance.stats["damageSecondary"]
		if typeof(receptacle.monsterPartInstance) != TYPE_NIL:
			secondaryCooldown += receptacle.monsterPartInstance.stats["secondaryCooldown"]
		if typeof(receptacle.monsterPartInstance) != TYPE_NIL:
			healCooldown += receptacle.monsterPartInstance.stats["healCooldown"]
	%MonsterDescription.text = "Health: %d
Primary Damage: %d
Secondary Damage: %d
Secondary Cooldown: %d
Heal: %d
Heal Cooldown: %d" % [health, primary, secondary, secondaryCooldown, heal, healCooldown]
	pass

func _on_reanimate_pressed() -> void:
	var receptacles = get_tree().get_nodes_in_group("Receptacle")
	for receptacle in receptacles:
		MonsterGlobal.MonsterAsortedParts.append(receptacle.monsterPartInstance)
	
	MonsterGlobal._asign_parts()
	get_tree().get_first_node_in_group("LevelLoader").load_level_scene("res://scenes/Arena/Arena.tscn")
	pass # Replace with function body.
