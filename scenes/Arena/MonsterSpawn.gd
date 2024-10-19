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
signal RoundEnd

var MonsterInstance
var PlayerMonster 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MonsterInstance = MonsterScene.instantiate()
	if player:
		MonsterInstance.Monster["Head"] = MonsterGlobal.PlayerMonster["Head"]
		MonsterInstance.Monster["Arms"] = MonsterGlobal.PlayerMonster["Arms"]
		MonsterInstance.Monster["Body"] = MonsterGlobal.PlayerMonster["Body"]
		MonsterInstance.Monster["Legs"] = MonsterGlobal.PlayerMonster["Legs"]
		MonsterInstance.Monster["Tail"] = MonsterGlobal.PlayerMonster["Tail"]
	else:
		print(_get_enemy_monster())
		MonsterInstance.Monster = _get_enemy_monster()
		MonsterInstance._make_enemy()
		print("Adding Enemy")
	add_child(MonsterInstance)
	MonsterInstance.died.connect(_died)
	MonsterInstance.PrimaryAttack.connect(_primaryAttack)
	MonsterInstance.SecondaryAttack.connect(_secondaryAttack)
	MonsterInstance.Heal.connect(_heal)
	HealthChanged.emit(get_child(0).HP)
	pass # Replace with function body.

func _enemy_round():
	await get_tree().create_timer(1).timeout
	var HP = get_child(0).HP
	var maxHP = $"../HUD/Control/Enemy".max_health
	var PlayerHP = get_parent()._get_player_hp()
	var PlayerMaxHP = $"../HUD/Control/Player".max_health
	
	#if HP < .5*maxHP:
		#HealAttack()
	if PlayerHP < .5*PlayerMaxHP:
		AttackPrimary()
	if PlayerHP > 0:
		if AttackSecondary():
			return
		AttackPrimary()

func _get_enemy_monster():
	Monster = EnemyGlobal.ActiveEnemy
	return Monster

func HealAttack():
	var heal = 10
	for part in get_child(0).Monster:
		heal += get_child(0).Monster[part].stats["heal"]
	Heal.emit(heal)
	HealthChanged.emit(get_child(0).HP)
	RoundEnd.emit()

func AttackPrimary():
	var damage = 10
	for part in get_child(0).Monster:
		damage += get_child(0).Monster[part].stats["damagePrimary"]
	PrimaryAttack.emit(damage)
	RoundEnd.emit()

func AttackSecondary():
	if !get_parent()._can_secondary():
		return false
	var damage = 20
	for part in get_child(0).Monster:
		damage += get_child(0).Monster[part].stats["damageSecondary"]
	PrimaryAttack.emit(damage)
	RoundEnd.emit()
	return true

func _recieve_damage(damage :int):
	if damage<0:
		damage = 10
	get_child(0).HP -= damage
	print(get_child(0).HP)
	HealthChanged.emit(get_child(0).HP)
	if get_child(0).HP <= 0:
		_died()

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
