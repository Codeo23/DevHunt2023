import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../features/scan/presentation/widget/draw_clip.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/constants/route_path.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreen();
}

class _ScanScreen extends State<ScanScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: DrawClip(0.0),
            child: Container(
              height: size.height * 0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [AppColors.greenSecondary, AppColors.greenPrimary],
                ),
              ),
              child: Center(
                child: Container(
                  height: size.height * 0.4,
                  width: size.height * 0.4,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: (result != null)
                  ? TextButton(
                      onPressed: () => context.go(RoutePath.homePath),
                      child: Text(
                        'Continuer en tant que Mialy Rak',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0,
                                  color:
                                      const Color.fromRGBO(207, 207, 207, 1)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: const Icon(
                            Icons.qr_code_scanner_outlined,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Scanner ici pour vous connectez',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

/**
 *
 */
