extends Node2D

@export var player :bool

var Monster :Dictionary
@export var MonsterScene :PackedScene

@export var DefaultEnemy :Dictionary = {"Head": 0, "Arms": 0, "Body": 0, "Legs": 0, "Tail": 0}

signal died
signal PrimaryAttack(damage :int)
signal SecondaryAttack(damage :int)
signal Heal(amount :int)
signal HealthChanged(health :int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var MonsterInstance = MonsterScene.instantiate()
	if player:
		MonsterInstance.Monster["Head"] = MonsterGlobal.PlayerMonster["Head"]
		MonsterInstance.Monster["Arms"] = MonsterGlobal.PlayerMonster["Arms"]
		MonsterInstance.Monster["Body"] = MonsterGlobal.PlayerMonster["Body"]
		MonsterInstance.Monster["Legs"] = MonsterGlobal.PlayerMonster["Legs"]
		MonsterInstance.Monster["Tail"] = MonsterGlobal.PlayerMonster["Tail"]
	else:
		MonsterInstance.Monster = _get_enemy_monster()
		MonsterInstance._make_enemy()
	add_child(MonsterInstance)
	MonsterInstance.died.connect(_died)
	MonsterInstance.PrimaryAttack.connect(_primaryAttack)
	MonsterInstance.SecondaryAttack.connect(_secondaryAttack)
	MonsterInstance.Heal.connect(_heal)
	pass # Replace with function body.

func _get_enemy_monster():
	var Monster :Dictionary

	Monster = DefaultEnemy
	return DefaultEnemy

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
