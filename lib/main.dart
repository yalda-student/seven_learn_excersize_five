import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:seven_learn_exercise_five/audio_file.dart';
import 'package:seven_learn_exercise_five/gen/assets.gen.dart';

void main() {
  runApp(const MyApp());
}

int seekingValue = 30000;

List playList = <AudioFile>[
  AudioFile(
      audioPath: Assets.audio.darandasht,
      cover: Assets.image.darandasht.path,
      name: 'Darandasht',
      artist: 'Mohsen Yeganeh'),
  AudioFile(
      audioPath: Assets.audio.kavir,
      cover: Assets.image.kavir.path,
      name: 'Kavir',
      artist: 'Mohsen Yeganeh'),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  late AudioFile currentAudioFile;

  final AudioPlayer audioPlayer = AudioPlayer();
  Duration? duration;
  Timer? timer;

  @override
  void initState() {
    currentAudioFile = playList[index];

    audioPlayer
        .setAudioSource(AudioSource.asset(currentAudioFile.audioPath))
        .then((value) {
      duration = value;
      audioPlayer.play();
      timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
        setState(() {});
      });
      setState(() {});
    });

    audioPlayer.processingStateStream.listen((state) async {
      if (state == ProcessingState.completed) {
        _playNextMusic();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
                child: _BlurBackground(currentAudioFile: currentAudioFile)),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(Assets.image.profile.path),
                        radius: 30,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Angelina Jolie',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '@angelina_jolie',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.heart,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          currentAudioFile.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Text(
                      currentAudioFile.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Text(
                      currentAudioFile.artist,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  if (duration != null)
                    Slider(
                      inactiveColor: Colors.white12,
                      activeColor: Colors.white,
                      max: duration!.inMilliseconds.toDouble(),
                      value: audioPlayer.position.inMilliseconds.toDouble(),
                      onChangeStart: (value) => audioPlayer.pause(),
                      onChangeEnd: (value) => audioPlayer.stop(),
                      onChanged: (value) => audioPlayer
                          .seek(Duration(milliseconds: value.toInt())),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          audioPlayer.position.toMinutesSeconds(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        if (duration != null)
                          Text(
                            duration!.toMinutesSeconds(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => _playPreviousMusic(),
                          icon: const Icon(
                            Icons.fast_rewind_rounded,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            final currentPosition = audioPlayer.position;

                            int newPosition =
                                currentPosition.inMilliseconds - seekingValue;
                            if (newPosition < 0) {
                              newPosition = 0;
                            }
                            audioPlayer
                                .seek(Duration(milliseconds: newPosition));
                          },
                          icon: const Icon(
                            Icons.replay_30_rounded,
                            color: Colors.white,
                          )),
                      _PlayButton(audioPlayer: audioPlayer),
                      IconButton(
                          onPressed: () {
                            final currentPosition = audioPlayer.position;
                            int newPosition =
                                currentPosition.inMilliseconds + seekingValue;
                            if (newPosition >= duration!.inMilliseconds) {
                              newPosition = duration!.inMilliseconds - 1000;
                            }
                            audioPlayer
                                .seek(Duration(milliseconds: newPosition));
                          },
                          icon: const Icon(
                            Icons.forward_30_rounded,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () => _playNextMusic(),
                          icon: const Icon(
                            Icons.fast_forward_rounded,
                            color: Colors.white,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _playPreviousMusic() {
    index--;
    index %= playList.length;
    currentAudioFile = playList[index];
    audioPlayer.setAudioSource(AudioSource.asset(currentAudioFile.audioPath));
  }

  void _playNextMusic() {
    index++;
    index %= playList.length;
    currentAudioFile = playList[index];
    audioPlayer.setAudioSource(AudioSource.asset(currentAudioFile.audioPath));
  }
}

class _BlurBackground extends StatelessWidget {
  const _BlurBackground({
    required this.currentAudioFile,
  });

  final AudioFile currentAudioFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: ExactAssetImage(currentAudioFile.cover),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 30,
          sigmaY: 30,
        ),
        child: Container(
          color: Colors.black26,
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (audioPlayer.playing) {
          audioPlayer.pause();
        } else {
          audioPlayer.play();
        }
      },
      child: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Color(0x5574FF7E),
                  blurRadius: 20,
                  offset: Offset(0, 3))
            ],
            gradient: LinearGradient(colors: [
              Color(0xff74FF7E),
              Color(0xff73C679),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Icon(
            audioPlayer.playing
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded,
            color: Colors.white,
            size: 40,
          )),
    );
  }
}

extension DurationExtensions on Duration {
  /// Converts the duration into a readable string
  /// 05:15
  String toHoursMinutes() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes";
  }

  /// Converts the duration into a readable string
  /// 05:15:35
  String toHoursMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String toMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}
