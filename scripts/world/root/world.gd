extends Node2D

@export var resourceObjects: Node2D
@export var constructionObjects: Node2D
@export var entities: Node2D
@export var forceColorPalleteShader: ColorRect

enum enemiesType {
	triangle
}

var enemies = {
	enemiesType.triangle: load("res://scenes/entities/enemies/enemyModel/root/enemyModel.tscn")
}

func _ready() -> void:
	WorldManager.spawn_enemy(enemies[enemiesType.triangle], Vector2(100, 100))

func _process(_delta: float) -> void:
	forceColorPalleteShader.global_position.x = PlayerManager.get_player().global_position.x - 576
	forceColorPalleteShader.global_position.y = PlayerManager.get_player().global_position.y - 324

func _on_spawn_resource_object_timer_timeout() -> void:
	WorldManager.spawn_resource_object()
