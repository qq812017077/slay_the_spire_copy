class_name MusicMaster
extends Node

const BGM_DIR: String = "res://arts/slay_the_spire/audios/musics/"


var bgm_map: Dictionary = {}

var main_tracks: Dictionary = {}
var tmp_tracks: Dictionary = {}


func _init() -> void:
    bgm_map.set("MENU", load_stream("STS_MenuTheme_NewMix_v1.ogg"))

func _ready() -> void:
    pass

func _process(delta: float) -> void:
    update_bgm(delta)
    update_temp_bgm(delta)

func update_bgm(_delta: float) -> void:
    for key in main_tracks.keys():
        var track: MusicPlayer = main_tracks[key]
        if track.is_done:
            main_tracks.erase(key)
            track.queue_free()


func update_temp_bgm(_delta: float) -> void:
    pass


func change_bgm(key: String) -> void:
    if bgm_map.has(key):
        var music: AudioStreamOggVorbis = bgm_map[key]
        var music_player = MusicPlayer.new(music)
        add_child(music_player)
        main_tracks.set(key, music_player)
        music_player.play()
    

func load_stream(file_name: String) -> AudioStream:
    return load(BGM_DIR + file_name)

func fade_out_bgm() -> void:
    for key in main_tracks.keys():
        var track: MusicPlayer = main_tracks[key]
        if not track.is_fading_out:
            track.fade_out()