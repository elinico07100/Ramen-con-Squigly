extends Area2D

var ingredientes = []
var contador = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.tipo == "squigly":
		body.quemao()
func _on_area_entered(area):
	if area.cayendo == true:
		var esta = area.tipo in ingredientes
		
		
		if esta == true:
			area.saltito()
		else:
			ingredientes.append(area.tipo)
			area.queue_free()
			contador += 1
			print(ingredientes, contador)
		
		
