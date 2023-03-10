import 'dart:io';

import 'package:ampio/core/domain/data/remote/repository/response_repository.dart';
import 'package:ampio/core/utils/Enums/loading_status.dart';
import 'package:ampio/features/response/presentation/bloc/response_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/widgets/blurred_container.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../../features/response/presentation/widget/audio_recorder.dart';
import '../../../core/utils/constants/route_path.dart';

class ResponseScreen extends StatefulWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  late final TextEditingController _textCommentController;
  FilePickerResult? resultFile;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;

  String? audioPath;

  @override
  void initState() {
    _textCommentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textCommentController.dispose();
    super.dispose();
  }

  void _pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      resultFile = await FilePicker.platform.pickFiles();
      print(resultFile);
      if (resultFile != null) {
        _fileName = resultFile!.files.first.name;
        pickedFile = resultFile!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());
        print('File name $_fileName');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResponseBloc(ResponseRepository())
        ..add(ResponseGetsEvent(post_id: 1)),
      child: Scaffold(
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
                child: Column(
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
                    BlocBuilder<ResponseBloc, ResponseState>(
                        builder: (context, state) {
                      if (state.status == LoadingStatus.loading) {
                        return Center(
                            child: SpinKitFadingCircle(
                          color: AppColors.greenSecondary,
                          size: 50.0,
                        ));
                      } else if (state.status == LoadingStatus.success) {
                        return Expanded(
                            child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return const Text('Text');
                                },
                                itemCount: state.responses.length));
                      }
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(
                                Icons.error_outline,
                                color: AppColors.yellowPrimary,
                                size: 60.sp,
                              ),
                            ),
                            Text(
                              'Impossible de charger les données',
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greySecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    })
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
                            child: SizedBox(
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: AppColors.greyPrimary),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _textCommentController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    AudioRecorder(
                                      onStop: (path) {
                                        print(path);
                                        setState(() {
                                          audioPath = path;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        _pickFile();
                                      },
                                      icon: const Icon(
                                        Icons.attach_file,
                                      ),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () => {
                                        context.push(RoutePath.codeEditor),
                                      },
                                      icon: const Icon(
                                        Icons.code,
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
                                        onPressed: () {
                                          context.read<ResponseBloc>().add(
                                                ResponseAddEvent(
                                                  content:
                                                      _textCommentController
                                                          .text,
                                                  filePath: audioPath,
                                                ),
                                              );
                                          _textCommentController.text = '';
                                          setState(() {
                                            audioPath = '';
                                          });
                                        },
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
      ),
    );
  }
}
