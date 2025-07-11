class_name CharacterInfo
extends Object

var name: String
var flavorText: String
var hp: String
var gold: int
var currentHp: int
var maxHp: int
var maxOrbs: int
var cardDraw: int
var player: AbstractPlayer
var relics: Array
var deck: Array
var resumeGame: bool


func _init(_name: String, _flavorText: String, _currentHp: int, _maxHP: int, _maxOrbs: int,
        _gold: int, _cardDraw: int, _player: AbstractPlayer, _relics: Array, _deck: Array, _resumeGame: bool) -> void:
    name = _name
    flavorText = _flavorText
    gold = _gold
    currentHp = _currentHp
    maxHp = _maxHP
    hp = str(currentHp) + "/" + str(maxHp)
    maxOrbs = _maxOrbs
    cardDraw = _cardDraw
    player = _player
    relics = _relics
    deck = _deck
    resumeGame = _resumeGame
