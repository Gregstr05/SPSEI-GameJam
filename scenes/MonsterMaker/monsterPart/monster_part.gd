extends Control

var monsterPartInstance : monsterPart
var monsterPartStats : Dictionary

@export var BlankSlotTexture : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if monsterPartInstance == null:
		$TextureRect.texture = BlankSlotTexture
	else:
		$TextureRect.texture = monsterPartInstance.icon
	
	pass # Replace with function body.

func _get_drag_data(_pos):
	
	var preview = Control.new()
	preview.set_anchors_and_offsets_preset(PRESET_TOP_LEFT)
	var textureRec = TextureRect.new()
	## Change to get actual texture or return null
	textureRec.set_anchors_and_offsets_preset(PRESET_TOP_LEFT)
	textureRec.texture = BlankSlotTexture
	textureRec.size = Vector2(512, 512)
	textureRec.scale = Vector2(.2, .2)
	preview.add_child(textureRec)
	# Pardon the magic numbers, but it just works
	textureRec.position = -1.152 * textureRec.size
	textureRec.position.x -= 350
	set_drag_preview(preview)
	
	#return monsterPartInstance
	return BlankSlotTexture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
