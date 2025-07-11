class_name ScreenShake
extends Node

enum ShakeDur {SHORT, MED, LONG, XLONG}
enum ShakeIntensity {LOW, MED, HIGH}

var x: float
var duration: float
var startDuration: float
var intensityValue: float
var intervalSpeed: float
var vertical: bool

func _process(delta: float) -> void:
    if duration > 0.0:
        duration -= delta
        if duration < 0.0:
            duration = 0.0
            CardGame.camera.position = Vector2(Settings.WIDTH, Settings.HEIGHT) / 2
            return
        
        # var tmp = MathHelper.lerp_snap()
        var tmp = CardGame.interpolation.apply_fade(0.1, intensityValue, duration / startDuration)
        x = cos((float(Time.get_ticks_msec() % 360)) / intervalSpeed) * tmp * 2

        if vertical:
            CardGame.camera.position = Vector2(Settings.WIDTH, Settings.HEIGHT + abs(self.x)) / 2
        else:
            CardGame.camera.position = Vector2(Settings.WIDTH + abs(self.x), Settings.HEIGHT) / 2

func shake(intensity: ShakeIntensity, dur: ShakeDur, isVertical: bool) -> void:
    self.duration = get_duration(dur)
    self.startDuration = self.duration
    self.intensityValue = get_intensity(intensity)
    self.vertical = isVertical;
    self.intervalSpeed = 0.3


func get_intensity(intensity: ShakeIntensity) -> float:
    match intensity:
        ShakeIntensity.LOW:
            return 20
        ShakeIntensity.MED:
            return 50
        ShakeIntensity.HIGH:
            return 100

    return 50

func get_duration(dur: ShakeDur) -> float:
    match dur:
        ShakeDur.SHORT:
            return 0.3
        ShakeDur.MED:
            return 0.5
        ShakeDur.LONG:
            return 1.0
        ShakeDur.XLONG:
            return 3.0

    return 1.0