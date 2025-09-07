class_name EnergyManager
extends Object

var energy: int = 0
var energy_master: int = 0
var energy_panel: EnergyPanel = null

func _init(e: int) -> void:
	energy_master = e
	energy = energy_master

func prep() -> void:
	energy = energy_master
	energy_panel.total_count = 0

func bind_panel(panel: EnergyPanel) -> void:
	energy_panel = panel
	energy_panel.total_count = energy

func recharge() -> void:
	energy_panel.set_energy(energy)

func use(e : int) -> void:
	energy_panel.use_energy(e)