extends CharacterBody2D

@export var speed: float = 300.0
@export var movement_threshold: float = 5.0

@export var raft_walkable_area: Rect2 = Rect2(-100, -50, 200, 100)

var target_local_position: Vector2

func _ready() -> void:
	target_local_position = position

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = target_local_position - position

	if direction.length() > movement_threshold:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	position.x = clamp(position.x, raft_walkable_area.position.x, raft_walkable_area.position.x + raft_walkable_area.size.x)
	position.y = clamp(position.y, raft_walkable_area.position.y, raft_walkable_area.position.y + raft_walkable_area.size.y)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		# Check if the mouse click is over any UI element and stop it
		if get_viewport().gui_get_tooltip().count > 0:
			return
		if get_parent():
			target_local_position = get_parent().to_local(get_global_mouse_position())
		else:
			target_local_position = get_global_mouse_position()
