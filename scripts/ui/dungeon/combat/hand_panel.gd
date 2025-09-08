class_name HandPanel
extends AbstractPanel

var player: AbstractPlayer = null

var card_widgets: Array[CardWidget] = []

func load_player(_player: AbstractPlayer) -> void:
    player = _player


func refresh_layout() -> void:
    
    for relic : AbstractRelic in player.relics:
        relic.on_refresh_hand()
    
    var hand_group_size: int = player.hand.group.size()
    var angle_range : float= 50.0 - ( 10 - hand_group_size) * 5.0
    var increment_angle : float = angle_range / hand_group_size
    var sink_start : float = 80.0
    var sink_range : float = 300.0
    var increment_sink: float = sink_range / hand_group_size / 2.0
    var middle = hand_group_size / 2

    for i: int in range(hand_group_size):
        card_widgets[i].set_angle(angle_range / 2.0 - increment_angle * i - increment_angle / 2.0)

