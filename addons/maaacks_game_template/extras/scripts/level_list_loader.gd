@tool
class_name LevelListLoader
extends SceneLister
## Extends [SceneLister] to manage level advancement through [GameLevelLog].

signal level_load_started
signal level_loaded
signal levels_finished

## Container where the level instance will be added.
@export var level_container : Node
## Loads a level on start.
@export var auto_load : bool = true
@export_file("*.tscn") var Default_scene_path : String
@export_group("Debugging")
@export var force_level : int = -1

var current_level : Node

func get_default_level() -> int:
	return EnemyGlobal.EnemyIndex
	#return GameLevelLog.get_current_level() if force_level == -1 else force_level

func get_level_file(level_id : int = get_default_level()):
	if files.is_empty():
		push_error("levels list is empty")
		return
	if level_id >= files.size():
		push_error("level_id is out of bounds of the levels list")
		level_id = files.size() - 1
	return files[level_id]

func advance_and_load_level():
	if advance_level():
		load_level_scene("res://scenes/MonsterMaker/MonsterMaker.tscn")

func advance_level() -> bool:
	#var level_id : int = get_default_level()
	EnemyGlobal.EnemyIndex += 1
	if EnemyGlobal.EnemyIndex >= EnemyGlobal.Enemy.size():
		emit_signal("levels_finished")
		EnemyGlobal.EnemyIndex = EnemyGlobal.Enemy.size() - 1
		return false
	GameLevelLog.level_reached(EnemyGlobal.EnemyIndex)
	EnemyGlobal._asign_parts()
	return true

func _attach_level(level_resource : Resource):
	assert(level_container != null, "level_container is null")
	var instance = level_resource.instantiate()
	level_container.call_deferred("add_child", instance)
	return instance

func load_level(level_id : int = get_default_level()):
	if is_instance_valid(current_level):
		current_level.queue_free()
		await current_level.tree_exited
		current_level = null
	var level_file = get_level_file(level_id)
	SceneLoader.load_scene(level_file, true)
	emit_signal("level_load_started")
	await(SceneLoader.scene_loaded)
	current_level = _attach_level(SceneLoader.get_resource())
	emit_signal("level_loaded")

func load_level_scene(scene_path :String):
	if is_instance_valid(current_level):
		current_level.queue_free()
		await current_level.tree_exited
		current_level = null
	SceneLoader.load_scene(scene_path, true)
	emit_signal("level_load_started")
	await(SceneLoader.scene_loaded)
	current_level = _attach_level(SceneLoader.get_resource())
	emit_signal("level_loaded")

func _ready():
	if Engine.is_editor_hint():
		# Text files get a `.remap` extension added on export.
		_refresh_files()
	if auto_load:
		for enemy in $"..".Enemies2:
			print(enemy)
			EnemyGlobal.Enemy.append(enemy)
		EnemyGlobal._asign_parts()
		load_level_scene("res://scenes/MonsterMaker/MonsterMaker.tscn")
		#load_level_scene(Default_scene_path)
		#load_level()
