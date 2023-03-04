import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../../core/presentation/widgets/custom_textfield.dart';

class SearchField extends StatelessWidget {

  final TextEditingController? textController;

  const SearchField({
    super.key,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {

    return SimpleShadow(
      offset: const Offset(0, 4),
      sigma: 7.0,
      color: Colors.black.withOpacity(0.25),
      child: SizedBox(
        width: 388.w,
        height: 51.h,
        child: CustomTextField(
          controller: textController,
          borderRadius: 34.r,
          hintText: 'Recherche',
          fillColor: Colors.white,
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 16.sp,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}