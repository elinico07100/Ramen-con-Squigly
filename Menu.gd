extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/BtnJugar.pressed.connect(_on_Jugar)
	$VBoxContainer/BtnSalir.pressed.connect(_on_salir)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_Jugar():
	get_tree().change_scene_to_file("res://escenas/Cocina.tscn")
	
func _on_salir():
	get_tree().quit()
