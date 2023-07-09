extends Node2D

var blocks = [
	preload("res://scenes/blocks/block_1.tscn"),
	preload("res://scenes/blocks/block_2.tscn"),
	preload("res://scenes/blocks/block_3.tscn"),
	preload("res://scenes/blocks/block_4.tscn"),
	preload("res://scenes/blocks/block_5.tscn"),
	preload("res://scenes/blocks/block_6.tscn"),
	preload("res://scenes/blocks/block_7.tscn"),
	preload("res://scenes/blocks/block_8.tscn"),
	preload("res://scenes/blocks/block_9.tscn"),
	preload("res://scenes/blocks/block_10.tscn"),
	preload("res://scenes/blocks/block_11.tscn"),
	preload("res://scenes/blocks/block_12.tscn"),
	preload("res://scenes/blocks/block_13.tscn"),
	preload("res://scenes/blocks/block_14.tscn"),
	preload("res://scenes/blocks/block_15.tscn"),
	preload("res://scenes/blocks/block_16.tscn"),
	preload("res://scenes/blocks/block_17.tscn"),
	preload("res://scenes/blocks/block_18.tscn"),
	preload("res://scenes/blocks/block_19.tscn"),
	preload("res://scenes/blocks/block_20.tscn"),
	preload("res://scenes/blocks/block_21.tscn"),
	preload("res://scenes/blocks/block_22.tscn"),
	preload("res://scenes/blocks/block_23.tscn"),
	preload("res://scenes/blocks/block_24.tscn"),
	preload("res://scenes/blocks/block_25.tscn"),
	preload("res://scenes/blocks/block_26.tscn"),
	preload("res://scenes/blocks/block_27.tscn"),
	preload("res://scenes/blocks/block_28.tscn"),
	preload("res://scenes/blocks/block_29.tscn"),
	preload("res://scenes/blocks/block_30.tscn"),
]

@onready var player = $"../Player"

const BLOCK_REMOVE_DIST := 1200.0
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
