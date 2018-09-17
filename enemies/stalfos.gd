extends "res://engine/entity.gd"

const SPEED = 40
const DAMAGE = 0.25

func _ready():
	$anim.play("default")
	movedir = dir.rand()
	$dirTimer.connect("timeout", self, "change_direction")
	set_physics_process(false)

func _physics_process(delta):
	entity_loop()

func change_direction():
	movedir = dir.rand()
