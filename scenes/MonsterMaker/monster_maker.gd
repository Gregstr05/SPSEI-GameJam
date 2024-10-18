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
