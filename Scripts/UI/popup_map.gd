extends Control

@onready var map_ui_element = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map_ui_element.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_map_toggle"):
		map_ui_element.visible = not map_ui_element.visible


func _on_btn_saltwick_pressed() -> void:
	pass # Replace with function body.
