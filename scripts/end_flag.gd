extends Area2D

@export_file var target_level
func _on_body_entered(body):
	Global.lastCheckpoint=null
	get_tree().change_scene_to_file.call_deferred(target_level)
