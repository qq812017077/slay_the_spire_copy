extends Node



func _ready() -> void:
    var rng1 = RandomNumberGenerator.new()
    var rng2 = RandomNumberGenerator.new()
    var rng3 = RandomNumberGenerator.new()


    rng1.seed = 1
    rng2.seed = 1
    rng3.seed = 1

    print("rng1.randi_range(1, 10): " + str(rng1.randi_range(1, 100)))
    print("rng2.randi_range(1, 10): " + str(rng2.randi_range(1, 100)))
    print("rng3.randi_range(1, 10): " + str(rng3.randi_range(1, 100)))