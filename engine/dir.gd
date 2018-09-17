extends Node

const CENTER = Vector2(0,0)
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)
const DOWN = Vector2(0,1) 
const UP = Vector2(0,-1)
const FLOOR = Vector2(0,0)

const MOVE_MAP = {
	LEFT: "left",
	RIGHT: "right",
	DOWN: "down", 
	UP: "up"
}

const REV_MOVE_MAP = {
	"left": LEFT,
	"right": RIGHT,
	"down": DOWN, 
	"up": UP
}

func _ready():
	randomize()

func rand():
	return REV_MOVE_MAP[REV_MOVE_MAP.keys()[ randi() % REV_MOVE_MAP.keys().size() ]]
