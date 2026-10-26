extends Area2D

var ingredientes = []
var contador = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area):
	if area.cayendo == true:
		ingredientes.append(area.tipo)
		print(ingredientes)
		area.queue_free()
		contador += 1
		print(contador)
		
