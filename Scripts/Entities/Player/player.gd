extends CharacterBody2D

enum State { IDLE, SELECTED, MOVING }

var state: State = State.IDLE
@export var speed: float = 65.0
@export var movement_threshold: float = 1.0
var raft_walkable_area: Rect2
var target_local_position: Vector2

@onready var map_popup: Control = get_tree().current_scene.find_child("PopupMap", true, false)
@onready var click_area: Area2D = $ClickArea

func _ready() -> void:
	target_local_position = position
	var area: Area2D = get_parent().get_node("WalkableArea")
	var shape_node: CollisionShape2D = area.get_node("CollisionShape2D")
	var shape: RectangleShape2D = shape_node.shape
	var pos: Vector2 = area.position + shape_node.position - shape.extents
	var size: Vector2 = shape.extents * 2
	raft_walkable_area = Rect2(pos, size)
	if click_area:
		click_area.input_event.connect(_on_click_area_input_event)

func _input(event: InputEvent) -> void:
	if map_popup and map_popup.visible:
		return
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_RIGHT and (state == State.SELECTED or state == State.MOVING):
			target_local_position = get_parent().to_local(get_global_mouse_position())
			state = State.MOVING
		elif event.button_index == MOUSE_BUTTON_LEFT and state == State.SELECTED:
			state = State.IDLE
			modulate = Color.WHITE

func _physics_process(_delta: float) -> void:
	if state == State.MOVING:
		var direction: Vector2 = target_local_position - position
		if direction.length() > movement_threshold:
			velocity = direction.normalized() * speed
		else:
			velocity = Vector2.ZERO
			position = target_local_position
			state = State.SELECTED
		move_and_slide()
		position.x = clamp(position.x, raft_walkable_area.position.x, raft_walkable_area.end.x)
		position.y = clamp(position.y, raft_walkable_area.position.y, raft_walkable_area.end.y)

func _on_click_area_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if state != State.SELECTED:
				state = State.SELECTED
				modulate = Color.GREEN
			else:
				state = State.IDLE
				modulate = Color.WHITE
		elif event.button_index == MOUSE_BUTTON_RIGHT and (state == State.SELECTED or state == State.MOVING):
			target_local_position = get_parent().to_local(get_global_mouse_position())
			state = State.MOVING
