extends Node2D

var Monster :Dictionary
var MonsterScene :String = "res://scenes/MonsterScene/MonsterScene.tscn"

signal died
signal PrimaryAttack(damage :int)
signal SecondaryAttack(damage :int)
signal Heal(amount :int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var MonsterInstance = load(MonsterScene)
	MonsterInstance.Monster["Head"] = Monster["Head"].texture
	MonsterInstance.Monster["Arms"] = Monster["Arms"].texture
	MonsterInstance.Monster["Body"] = Monster["Body"].texture
	MonsterInstance.Monster["Legs"] = Monster["Legs"].texture
	MonsterInstance.Monster["Tail"] = Monster["Tail"].texture
	add_child(MonsterInstance)
	MonsterInstance.died.connect(_died)
	MonsterInstance.PrimaryAttack.connect(_primaryAttack)
	MonsterInstance.SecondaryAttack.connect(_secondaryAttack)
	MonsterInstance.Heal.connect(_heal)
	pass # Replace with function body.

func _died():
	died.emit()

func _primaryAttack(damage :int):
	PrimaryAttack.emit(damage)

func _secondaryAttack(damage :int):
	SecondaryAttack.emit(damage)

func _heal(amount :int):
	Heal.emit(amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
