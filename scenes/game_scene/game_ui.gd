extends Control

@export var win_scene : PackedScene
@export var lose_scene : PackedScene
@export var Enemies :Array[monsterEnemyResource]
@export var Enemies2 :Array[monsterEnemyResource]
func _ready():
	InGameMenuController.scene_tree = get_tree()
	print(EnemyGlobal.Enemy)

func _on_level_lost():
	InGameMenuController.open_menu(lose_scene, get_viewport())
	MonsterGlobal.PlayerMonster = {"Head": 0, "Arms": 0, "Body": 0, "Legs": 0, "Tail": 0}

func _on_level_won():
	$LevelLoader.advance_and_load_level()

func _on_level_loader_level_loaded():
	await $LevelLoader.current_level.ready
	if $LevelLoader.current_level.has_signal("level_won"):
		$LevelLoader.current_level.level_won.connect(_on_level_won)
	if $LevelLoader.current_level.has_signal("level_lost"):
		$LevelLoader.current_level.level_lost.connect(_on_level_lost)
	$LoadingScreen.close()

func _on_level_loader_levels_finished():
	InGameMenuController.open_menu(win_scene, get_viewport())

func _on_level_loader_level_load_started():
	$LoadingScreen.reset()
