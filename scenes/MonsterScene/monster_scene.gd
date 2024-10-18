extends Node2D

var Monster :Dictionary

var HP :int

signal died


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Head.texture = Monster["Head"]
	$Arms.texture = Monster["Arms"]
	$Body.texture = Monster["Body"]
	$Legs.texture = Monster["Legs"]
	$Tail.texture = Monster["Tail"]
	
	HP = Monster["HP"]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
