extends Control

var monsterPartInstance : monsterPart
var monsterPartStats : Dictionary
var monsterPartTypes = ["Head", "Arms", "Body", "Legs", "Tail"]

@export var receptacle :bool = false

@export var BlankSlotTexture : Texture2D
@export var PartPreviewScene : PackedScene

signal dropped
signal sendData(data :monsterPart)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if monsterPartInstance == null:
		$TextureRect.texture = BlankSlotTexture
	else:
		$TextureRect.texture = monsterPartInstance.icon
	
	if receptacle:
		dropped.emit()
	pass # Replace with function body.

func _get_drag_data(_pos):
	if receptacle:
		return null
	set_drag_preview(_make_preview())
	
	return monsterPartInstance

func _make_preview():
	var preview = Control.new()
	preview.set_anchors_and_offsets_preset(PRESET_TOP_LEFT)
	var textureRec = TextureRect.new()
	textureRec.set_anchors_and_offsets_preset(PRESET_TOP_LEFT)
	## Change to get actual texture or return null
	#textureRec.texture = BlankSlotTexture
	if typeof(monsterPartInstance) == TYPE_NIL:
		return null
	textureRec.texture = monsterPartInstance.icon
	textureRec.size = Vector2(512, 512)
	textureRec.scale = Vector2(.2, .2)
	preview.add_child(textureRec)
	# Pardon the magic numbers, but it just works
	textureRec.position = -1.152 * textureRec.size
	textureRec.position.x -= 350
	return preview

func _can_drop_data(_pos, data):
	if data is monsterPart:
		if _check_same_part(data.type):
			return receptacle
	return false

func _check_same_part(type) -> bool:
	var receptacles = get_tree().get_nodes_in_group("Receptacle")
	for partNode in receptacles:
		if typeof(partNode.monsterPartInstance) == TYPE_NIL:
			continue
		if partNode.monsterPartInstance.type == type:
			if partNode == self:
				return true
			else:
				return false
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	monsterPartInstance = data
	$Type.show()
	$Type.text = monsterPartTypes[data.type]
	_ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_rect_mouse_entered() -> void:
	sendData.emit(monsterPartInstance)
	pass # Replace with function body.
