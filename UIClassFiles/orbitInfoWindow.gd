class_name orbitInfoWindow extends Window

func _ready() -> void:
	gui_embed_subwindows = true
	close_requested.connect(queue_free)
	borderless = true
## 重新指定窗口内文本的内容并调整窗口大小
func reassignText(text: String) -> void:
	$Margin/Label.text = text
	var new_size = $Margin/Label.size
	new_size += Vector2(10, 10)
	self.size = new_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
