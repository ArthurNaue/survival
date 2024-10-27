extends ProgressBar
class_name HealthBarComponent

signal UpdateBar(newValue: int)

func _on_update_bar(newValue: int) -> void:
	visible = true
	value = newValue
	await get_tree().create_timer(0.5).timeout
	visible = false
