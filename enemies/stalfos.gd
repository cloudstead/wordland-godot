extends "res://engine/entity.gd"

const SPEED = 40

func _ready():
	$anim.play("default")
	movedir = dir.rand()

func _physics_process(delta):
	entity_loop()

func _on_Timer_timeout():
	movedir = dir.rand()
