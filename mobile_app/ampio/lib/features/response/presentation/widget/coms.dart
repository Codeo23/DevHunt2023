import 'dart:io';

import 'package:ampio/core/utils/function/numberToTowDigits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/colors/app_colors.dart';

class Coms extends StatefulWidget {
  const Coms({Key? key}) : super(key: key);

  @override
  State<Coms> createState() => _ComsState();
}

class _ComsState extends State<Coms> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    print('Recorded audio: $audioFile');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: recorder.onProgress,
            builder: (context, snapshot) {
              final duration =
                  snapshot.hasData ? snapshot.data!.duration : Duration.zero;

              final twoDigitsMin =
                  numberToTwoDigits(duration.inMinutes.remainder(60));
              final twoDigitsSecs =
                  numberToTwoDigits(duration.inSeconds.remainder(60));

              return Text('$twoDigitsMin:$twoDigitsSecs');
            }),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/avatar.jpg',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: AppColors.greyPrimary),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () async {
                          if (recorder.isRecording) {
                            await stop();
                          } else {
                            await record();
                          }

                          setState(() {});
                        },
                        icon: recorder.isRecording
                            ? Icon(Icons.stop)
                            : Icon(Icons.mic),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () => {},
                        icon: const Icon(
                          Icons.attach_file,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () => {},
                        icon: const Icon(
                          Icons.image,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            AppColors.greenSecondary,
                            AppColors.greenAccentThirdly
                          ]),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          onPressed: () => {},
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
