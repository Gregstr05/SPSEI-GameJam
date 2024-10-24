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

signal popup(amount :int)

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
	var HP = $"../HUD/Control/Enemy".health
	var maxHP = $"../HUD/Control/Enemy/%HealthBar".max_value
	var PlayerHP = get_parent()._get_player_hp()
	var PlayerMaxHP = $"../HUD/Control/Player/%HealthBar".max_value
	
	if HP < maxHP*0.5:
		if get_child(0)._calculate_health() > 0:
			print("Trying healing")
			if get_parent()._can_heal():
				print("healing")
				HealAttack()
				$"..".EnemyHealCooldown = get_child(0).HealCooldown
				return
		print("Heal failed")
	#	AttackPrimary()
	if PlayerHP > 0:
		print("Trying secondary")
		if AttackSecondary():
			$"..".EnemySecondaryCooldown = get_child(0).SecondaryCooldown
			return
		print("Secondary failed, attacking primary")
		AttackPrimary()
	if PlayerHP < .5*PlayerMaxHP:
		print("Attacking primary")
		AttackPrimary()

func _get_enemy_monster():
	Monster = EnemyGlobal.ActiveEnemy
	return Monster

func HealAttack():
	var heal = 10
	for part in get_child(0).Monster:
		heal += get_child(0).Monster[part].stats["heal"]
	if heal < 0:
		heal = 10
	Heal.emit(heal)
	HealthChanged.emit(get_child(0).HP)
	RoundEnd.emit()
	return true

func AttackPrimary():
	var damage = 10
	for part in get_child(0).Monster:
		damage += get_child(0).Monster[part].stats["damagePrimary"]
	PrimaryAttack.emit(damage)
	_attack_anim()
	RoundEnd.emit()

func AttackSecondary():
	if !get_parent()._can_secondary():
		return false
	var damage = 20
	for part in get_child(0).Monster:
		damage += get_child(0).Monster[part].stats["damageSecondary"]
	PrimaryAttack.emit(damage)
	_attack_anim()
	RoundEnd.emit()
	return true

func _attack_anim():
	var tween = get_tree().create_tween()
	var original_loc = position
	tween.tween_property(self, "position", Vector2(0, 0), .2)
	tween.tween_property(self, "position", original_loc, .4)

func _recieve_damage(damage :int):
	if damage<0:
		damage = 10
	get_child(0).HP -= damage
	print(get_child(0).HP)
	popup.emit(-damage)
	HealthChanged.emit(get_child(0).HP)
	if get_child(0).HP <= 0:
		_died()

func _died():
	print("Died")
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


func _on_heal(amount: int) -> void:
	get_child(0).HP += amount
	print(get_child(0).HP)
	popup.emit(amount)
	HealthChanged.emit(get_child(0).HP)
	if get_child(0).HP <= 0:
		_died()
	pass # Replace with function body.
