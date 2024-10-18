extends Control

var monsterPartInstance : monsterPart
var monsterPartStats : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = monsterPartInstance.texture
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
