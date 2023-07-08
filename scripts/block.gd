extends Node2D

func getTilemapHeight():
	var tilemap: TileMap = $TileMap
	var cell_bounds = tilemap.get_used_rect()
	var height_count = cell_bounds.size.y
	return height_count * 18
