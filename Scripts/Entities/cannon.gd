extends Sprite2D

@onready var area: Area2D = $Area2D
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	print("Cannon ready, Area2D monitoring: ", area.monitoring)  # Debug: Confirm setup

func _on_body_entered(body: Node2D) -> void:
	print("Body entered: ", body.name)  # Debug: What entered?
	if body.name == "Player":
		color_rect.color = Color.RED

func _on_body_exited(body: Node2D) -> void:
	print("Body exited: ", body.name)  # Debug
	if body.name == "Player":
		color_rect.color = Color(1, 1, 1, 0.203922)
