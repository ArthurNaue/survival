extends Node2D

@export var campfire: StaticBody2D
@export var resourceObjects: Node2D
@export var resourceObjectsTimer: Timer
@export var constructionObjects: Node2D
@export var entities: Node2D
@export var forceColorPalleteShader: ColorRect

var night := false

func _ready() -> void:
	resourceObjectsTimer.start()

func _process(_delta: float) -> void:
	forceColorPalleteShader.global_position.x = PlayerManager.get_player().global_position.x - 576
	forceColorPalleteShader.global_position.y = PlayerManager.get_player().global_position.y - 324

func _on_spawn_resource_object_timer_timeout() -> void:
	WorldManager.spawn_resource_object()

func _on_day_cicle_timer_timeout() -> void:
	night = !night
	
	if night:
		campfire.turn_lights_on()
		resourceObjectsTimer.stop()
		
		var enemiesNumber = randi_range(3, 6)
		for enemies in enemiesNumber:
			var enemyPosition = Vector2(randi_range(100, 600), randi_range(100, 600))
			WorldManager.spawn_enemy(load("res://scenes/entities/enemies/enemyModel/root/enemyModel.tscn"), enemyPosition)
	else:
		campfire.turn_lights_off()
		resourceObjectsTimer.start()
