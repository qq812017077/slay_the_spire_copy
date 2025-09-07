class_name CombatUI
extends Control

const ENERGY_PANEL_SHOW_POS: Vector2 = Vector2(198, 890)
const ENERGY_PANEL_HIDE_POS: Vector2 = Vector2(-420, 890)

const COMBAT_DECK_PANEL_SHOW_POS: Vector2 = Vector2(64, 1080 - 64)
const COMBAT_DECK_PANEL_HIDE_POS: Vector2 = Vector2(-300 + 64, 1080 + 300 - 64)

const DISCARD_PILE_PANEL_SHOW_POS: Vector2 = Vector2(1920 - 156 + 64, 1080 - 64)
const DISCARD_PILE_PANEL_HIDE_POS: Vector2 = Vector2(1920 + 64, 1080 + 300 - 64)

@export var energy_panel: EnergyPanel = null
@export var combat_deck_panel: DrawPilePanel = null
@export var discard_pile_panel: DiscardPilePanel = null

var player: AbstractPlayer = null

var loaded: bool = false
var is_hidden: bool = false
func _ready() -> void:
	energy_panel.set_pos(ENERGY_PANEL_SHOW_POS, ENERGY_PANEL_HIDE_POS)
	combat_deck_panel.set_pos(COMBAT_DECK_PANEL_SHOW_POS, COMBAT_DECK_PANEL_HIDE_POS)
	discard_pile_panel.set_pos(DISCARD_PILE_PANEL_SHOW_POS, DISCARD_PILE_PANEL_HIDE_POS)
	hide_combat_ui(true)

	await get_tree().create_timer(1.0).timeout

	player = IronClad.new()
	energy_panel.load_player(player)
	combat_deck_panel.load_player(player)
	show_combat_ui()

func _process(_delta: float) -> void:
	if is_hidden:
		return
	combat_deck_panel.update_draw_pile(player.draw_pile.group.size())
	discard_pile_panel.update_discard_pile(player.discard_pile.group.size())

func show_combat_ui() -> void:
	if not is_hidden:
		return
	is_hidden = false
	energy_panel.show_panel()
	combat_deck_panel.show_panel()
	discard_pile_panel.show_panel()

func hide_combat_ui(instant: bool = false) -> void:
	if is_hidden:
		return
	is_hidden = true
	energy_panel.hide_panel(instant)
	combat_deck_panel.hide_panel(instant)
	discard_pile_panel.hide_panel(instant)
