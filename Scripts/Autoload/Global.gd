extends Node

@export var cities: Array[CityData] = []  # Populate in Inspector: add CityData instances
var current_city_name: String = "Saltwick"

func get_city_position(city_name: String) -> Vector2:
	for city in cities:
		if city.name == city_name:
			return city.position
	return Vector2.ZERO

func set_player_city(new_city_name: String):
	if get_city_position(new_city_name) != Vector2.ZERO:
		current_city_name = new_city_name
