import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../features/response/presentation/widget/response_item.dart';
import '../../../../core/presentation/widgets/blurred_container.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../../features/response/presentation/widget/audio_player.dart';
import '../../../../features/response/presentation/widget/audio_recorder.dart';

class ResponseScreen extends StatefulWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  bool showPlayer = false;
  String? audioPath;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -20,
              right: -10,
              child: BlurredContainer(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.chevron_left),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Réponses',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      Text(
                        'Hasina BG',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 12.sp),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '1 min',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Parsing JSON array and object in Android Studio',
                    style: GoogleFonts.poppins(fontSize: 16.sp),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Réponses',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 14.sp,
                      )
                    ],
                  ),
                  ResponseItem(),
                  const SizedBox(height: 5),
                  ResponseItem(),
                  const SizedBox(height: 150)
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  children: [
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
                                  border: Border.all(
                                      width: 1, color: AppColors.greyPrimary),
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
                                  AudioRecorder(
                                    onStop: (path) {
                                      if (kDebugMode)
                                        print('Recorded file path: $path');
                                      setState(() {
                                        audioPath = path;
                                      });
                                    },
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
                                      onPressed: () {},
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
