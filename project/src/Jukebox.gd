extends AudioStreamPlayer


export var menu_track : AudioStream
export var game_track : AudioStream


func play_menu_track():
	_play_if_different(menu_track)
	
	
func play_game_track():
	_play_if_different(game_track)


func _play_if_different(new_stream:AudioStream)->void:
	if stream != new_stream:
		stream = new_stream
		playing = true
