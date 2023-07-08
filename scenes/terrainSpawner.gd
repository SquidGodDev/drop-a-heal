extends Node2D

var blocks = [
	preload("res://scenes/blocks/block_1.tscn"),
	preload("res://scenes/blocks/block_2.tscn"),
	preload("res://scenes/blocks/block_3.tscn"),
	preload("res://scenes/blocks/block_4.tscn"),
]

@onready var player = $"../Player"

const BLOCK_REMOVE_DIST := 1000.0
const BLOCK_SPAWN_DIST := 200.0
var nextSpawnY: float

# Called when the node enters the scene tree for the first time.
func _ready():
	nextSpawnY = get_child(0).getTilemapHeight()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var current_blocks = get_children()
	for block in current_blocks:
		# remove block if too far from player
		if player.position.y - block.position.y > BLOCK_REMOVE_DIST:
			block.queue_free()
	if nextSpawnY - player.position.y < BLOCK_SPAWN_DIST:
		var randomBlock = blocks[randi() % blocks.size()]
		var blockInstance = randomBlock.instantiate()
		add_child(blockInstance)
		blockInstance.position.y = nextSpawnY
		nextSpawnY += blockInstance.getTilemapHeight()
