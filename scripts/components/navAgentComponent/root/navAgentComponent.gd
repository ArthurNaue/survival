extends NavigationAgent2D
class_name NavAgentComponent

#variaveis onready
@export var parent: CharacterBody2D
@onready var campfire = WorldManager.get_world().get_node("navRegion").get_node("campfire")

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
	if campfire != null:
		#define a posicao do player
		target_position = campfire.global_position
	#reinicia o cooldown
	cooldown = 0.5
