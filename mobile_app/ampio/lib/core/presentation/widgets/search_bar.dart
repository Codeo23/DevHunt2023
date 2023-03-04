import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Recherche de question',
        hintStyle: GoogleFonts.poppins(
          fontSize: 14.sp
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 5,
        ),
        prefixIcon: Icon(Icons.search,size: 20.sp),

      ),
    );
  }
}
