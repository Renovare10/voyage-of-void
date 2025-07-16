extends Control

@onready var map_ui_element = self

@export var location_container_path: NodePath
@export var saltwick_scene: PackedScene
@export var royal_anchorage_scene: PackedScene

var location_container: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map_ui_element.visible = false
	location_container = get_node(location_container_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_map_toggle"):
		map_ui_element.visible = not map_ui_element.visible
		
func _clear_current_scene() -> void:
	# Unload the current location if one exists
	if location_container.get_child_count() > 0:
		var current_location = location_container.get_child(0)
		current_location.queue_free()
		
func _load_new_scene(scene: PackedScene) -> void:
	var new_location = scene.instantiate()
	location_container.add_child(new_location)
		
func _on_btn_saltwick_pressed() -> void:
	self._clear_current_scene()
	self._load_new_scene(saltwick_scene)
	# Hide the map UI after jump
	self.visible = false


func _on_btn_royal_anchorage_pressed() -> void:
	self._clear_current_scene()
	self._load_new_scene(royal_anchorage_scene)
	# Hide the map UI after jump
	self.visible = false
