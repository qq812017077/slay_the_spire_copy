class_name CharacterManager
extends Object

static var character_list: Array[AbstractPlayer] = []

static func initialize() -> void:
    character_list.append(IronClad.new())
    character_list.append(TheSilent.new())
    character_list.append(Defect.new())
    character_list.append(Watcher.new())

static func get_character(player_type: AbstractPlayer.PlayerType) -> AbstractPlayer:
    for character in character_list:
        if character.type == player_type:
            return character
    return null

static func recreate_character(player_type: AbstractPlayer.PlayerType) -> AbstractPlayer:
    for old in character_list:
        if old.type == player_type:
            var new_char = old.new_instance()
            character_list.set(character_list.find(old), new_char)
            return new_char
    return null