double prevValue = 0.0;
double turns = 0;

double getTurnsByDegrees(double? degrees) {
  double? direction = degrees ?? 0;
  direction = (direction < 0) ? (360 + direction) : direction;

  double diff = direction - prevValue;
  if (diff.abs() > 180) {
    if (prevValue > direction) {
      diff = 360 - (direction - prevValue).abs();
    } else {
      diff = 360 - (prevValue - direction).abs();
      diff = diff * -1;
    }
  }

  turns += (diff / 360);
  prevValue = direction;

  return turns * -1;
}
