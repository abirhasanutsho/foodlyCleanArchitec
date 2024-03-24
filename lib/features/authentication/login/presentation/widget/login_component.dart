
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/utils.dart';



Widget customTextField(

    {required TextEditingController controller,
      required String hintText,
      required IconData iconName,
      VoidCallback ? onTabfunction
    }) {

  return Container(
    margin: EdgeInsets.only(top: 15),
    width: 315,
    height: 48,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.lightgreycolor),
      color: AppColors.lightgreycolor,
      borderRadius: BorderRadius.circular(14),
    ),
    child: TextField(
      onTap:onTabfunction,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(iconName),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: const Color(0xffbec3ca),
        ),
        border: InputBorder.none,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    ),
  );
}

Widget passwordTextField(
    {required TextEditingController controller,
      required String hintText,
      required IconData iconName}) {
  bool obscureText = true;
  return Container(
    margin: EdgeInsets.only(top: 15),
    width: 315,
    height: 48,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.lightgreycolor),
      color: AppColors.lightgreycolor,
      borderRadius: BorderRadius.circular(14),
    ),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffix: InkWell(
          onTap: () {
            obscureText = !obscureText;

          },
          child: Icon(Icons.visibility),
        ),
        prefixIcon: Icon(iconName),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: const Color(0xffbec3ca),
        ),
        border: InputBorder.none,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    ),
  );
}

//Password textfield......................

class PasswordTextField extends StatefulWidget {
  TextEditingController controller;
  final String hintText;
  final IconData iconName;

  PasswordTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.iconName,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: 315,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightgreycolor),
        color: AppColors.lightgreycolor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.iconName),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: const Color(0xffbec3ca),
          ),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}