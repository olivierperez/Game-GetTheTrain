extends Camera2D


@export var tileMap: TileMap


func _ready():
	var tile_map_end = tileMap.get_used_rect().end
	var tile_size = tileMap.tile_set.tile_size
	var max_x = (tile_map_end.x - 1) * tile_size.x
	var max_y = (tile_map_end.y - 1) * tile_size.y
	limit_right = max_x
	limit_bottom = max_y
