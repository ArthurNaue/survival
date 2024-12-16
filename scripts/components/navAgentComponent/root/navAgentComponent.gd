extends NavigationAgent2D
class_name NavAgentComponent

#variaveis onready
@export var parent: CharacterBody2D
@onready var player = PlayerManager.get_player()

#variaveis
var cooldown := 0.5

func _physics_process(_delta: float) -> void:
	#diminui o cooldown por delta
	cooldown -= _delta

	#verifica se o cooldown acabou
	if cooldown <= 0:
		#define o caminho
		make_path()

func bake_region() -> void:
	WorldManager.get_nav_region().bake_navigation_polygon()

#funcao de definir o caminho
func make_path() -> void:
	bake_region()
	if player != null:
		#define a posicao do player
		target_position = player.global_position
	#reinicia o cooldown
	cooldown = 0.5
