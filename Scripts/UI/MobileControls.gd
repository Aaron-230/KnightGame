extends CanvasLayer

func _ready() -> void:
	if DisplayServer.is_touchscreen_available():
		self.show()
	else:
		self.hide()
