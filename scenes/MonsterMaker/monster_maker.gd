extends Node2D

@export var ItemScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _populate_grid():
	for i in 25:
		var ItemSlot = ItemScene.instantiate()
		
		%GridContainer.add_child(ItemSlot)
