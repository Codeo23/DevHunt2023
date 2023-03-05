import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../features/scan/presentation/widget/draw_clip.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/presentation/widgets/custom_button.dart';
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
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: DrawClip(0.0),
            child: Container(
              height: size.height * 0.9,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [AppColors.greenSecondary, AppColors.greenPrimary],
                ),
              ),
              child: Center(
                child: SizedBox(
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: (result != null)
                  ? CustomButton(
                    onPressed: () => context.go(RoutePath.homePath),
                    height: 200,
                    backgroundColor: Colors.transparent,
                    labelButton: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Image(
                            image: AssetImage(
                              'assets/images/checks.png',
                            ),
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Continuer en tant que Mialy Rak',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                              color: Colors.black
                            ),
                          )
                        ],
                      ),
                  )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.qr_code_scanner_outlined,
                          size: 100,
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
