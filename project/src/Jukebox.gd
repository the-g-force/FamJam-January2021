extends AudioStreamPlayer


export var menu_track : AudioStream
export var game_track : AudioStream


func play_menu_track():
	if stream != menu_track:
		stream = menu_track
		playing = true
	
	
func play_game_track():
	stream = game_track
	playing = true
	
