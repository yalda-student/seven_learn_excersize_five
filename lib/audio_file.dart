class AudioFile {
  final String audioPath;
  final String cover;
  final String name;
  final String artist;

  AudioFile(
      {required this.audioPath,
      required this.cover,
      required this.name,
      required this.artist});

  @override
  String toString() {
    return 'AudioFile{audioPath: $audioPath, name: $name, artist: $artist}';
  }
}
