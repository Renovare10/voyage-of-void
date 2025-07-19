extends CharacterBody2D

@export var speed: float = 65.0
var target_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	var cannon = get_parent().get_node("Cannon")  # Assume one; loop for nearest later
	var color_rect = cannon.get_node("ColorRect")
	target_pos = cannon.position + color_rect.position + (color_rect.size / 2)  # Center of rect for exact manning spot

func _physics_process(delta: float) -> void:
	if position != target_pos:
		position = position.move_toward(target_pos, speed * delta)
		move_and_slide()
