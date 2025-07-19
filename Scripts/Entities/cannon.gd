extends Sprite2D

@onready var area: Area2D = $Area2D
@onready var color_rect: ColorRect = $ColorRect

var manned_by: Node2D = null  # Track for multi if needed

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.get_node("ManningComponent"):  # Component check
		manned_by = body
		color_rect.color = Color.RED

func _on_body_exited(body: Node2D) -> void:
	if body == manned_by:
		manned_by = null
		color_rect.color = Color(1, 1, 1, 0.203922)
