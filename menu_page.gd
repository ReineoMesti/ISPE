extends Control

@onready var entry_button = $PageContent/Panel/Entry
@onready var exit_button = $PageContent/Panel/Exit

func switch_to_battle() -> void:
	get_tree().change_scene_to_file("res://storyboard.tscn")
	print("changed.")
	pass

func exit_program() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _ready() -> void:
	entry_button.pressed.connect(switch_to_battle)
	exit_button.pressed.connect(exit_program)
	print("Init")
	pass


func _process(delta: float) -> void:
	pass
