extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _popup(amount :int):
	var tween = get_tree().create_tween()
	var number = Label.new()
	number.text = "%d" %amount
	number.add_theme_color_override("font_color", Color.GREEN if amount>0 else Color.RED)
	number.add_theme_font_size_override("font_size", 32)
	number.size = Vector2(50, 50)
	add_child(number)
	
	tween.tween_property(number, "position", position-Vector2(50, 100), 3)
	tween.parallel()
	tween.tween_property(number, "modulate", Color(255,255,255,0), 3)
	tween.tween_callback(number.queue_free)
	pass
