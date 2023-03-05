import 'package:ampio/core/utils/function/numberToTowDigits.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayAudio extends StatefulWidget {
  const PlayAudio({Key? key}) : super(key: key);

  @override
  State<PlayAudio> createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  // Audio player
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    String url =
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
    await audioPlayer.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await audioPlayer.seek(position);

              await audioPlayer.resume();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${numberToTwoDigits(position.inMinutes)}:${numberToTwoDigits(position.inSeconds)}',
                ),
                Text(
                  '${numberToTwoDigits(duration.inMinutes)}:${numberToTwoDigits(duration.inSeconds)}',
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () async {
                if (isPlaying) {
                  await audioPlayer.pause();
                } else {
                  await audioPlayer.resume();
                }
              },
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow))*/
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.5),
              child: Image.asset(
                'assets/images/avatar.jpg',
                height: 25,
                width: 25,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hasina BG',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 12.sp),
                ),
                Text(
                  '2h',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.resume();
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                ),
            ),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);

                await audioPlayer.resume();
              },
            ),
            Text(
              '${numberToTwoDigits(position.inMinutes)}:${numberToTwoDigits(position.inSeconds)}',
            ),
          ],
        )
      ],
    );
  }
}
