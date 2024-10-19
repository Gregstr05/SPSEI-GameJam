extends Control

var Monstername :String
var health :int
var max_health :int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%HealthBar.value = health
	$Player_info/VBoxContainer/Name.text = Monstername
	pass # Replace with function body.

func _set_max_health(max_health):
	%HealthBar.max_value = max_health

func _health_changed(health :int):
	self.health = health
	%HealthBar.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
