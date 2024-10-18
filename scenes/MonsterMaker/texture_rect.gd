extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _can_drop_data(_pos, data):
	print(data)
	if data is monsterPart:
		return true
	return false


func _drop_data(at_position: Vector2, data: Variant) -> void:
	print(data.stats)
