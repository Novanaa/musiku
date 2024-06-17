String parseDuration(int duration) {
  Duration convertedDuration = Duration(milliseconds: duration);
  String durationInMinutes = convertedDuration.inMinutes < 10
      ? "0${convertedDuration.inMinutes}"
      : convertedDuration.inMinutes.toString();
  int durationInSeconds = duration % 60.ceil();

  return "$durationInMinutes:${durationInSeconds.ceil()}";
}
