extends Resource
class_name ConstructionObjectsStats

@export var constructionType: ConstructionManager.constructionTypes

@export_group("requirements")
@export var requirementNumber: Array[ItemStats]
@export_group("")

@export_group("ingredients")
@export var ingredientsNumber: Array[ItemStats]
@export var resultItem: ItemStats
@export_group("")

@export_group("turret")
@export_range(1, 10) var damage: int
@export_range(1, 5) var cooldown: int
@export_group("")

@export_group("nodes")
@export var sprite: Texture
@export_group("")
