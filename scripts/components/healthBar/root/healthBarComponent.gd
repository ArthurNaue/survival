extends ProgressBar
class_name HealthBarComponent

signal UpdateBar(newValue: int)

func _ready() -> void:
	UpdateBar.connect(_on_update_bar)

func _on_update_bar(newValue: int) -> void:
	value = newValue
	if !visible:
		visible = true
		await get_tree().create_timer(0.5).timeout
		visible = false
