extends TileMapLayer

func get_walkable_area() -> Rect2:
	var area: Area2D = $WalkableArea
	var shape: RectangleShape2D = area.get_node("CollisionShape2D").shape
	var pos: Vector2 = area.position + area.get_node("CollisionShape2D").position - shape.extents
	var size: Vector2 = shape.extents * 2
	return Rect2(pos, size)
