import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/custom_color.dart';
import '../../../core/constant/images_assets.dart';
class RadioTabs extends StatelessWidget {
  const RadioTabs({super.key});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(ImagePngLight.radio),
        SizedBox(height: mediaQuery.height*0.03),
        Text("إذاعة القرآن الكريم",style: GoogleFonts.elMessiri(
          fontSize: 25,
          fontWeight: FontWeight.w600
        ),),
        SizedBox(height: mediaQuery.height*0.06),
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            onClickIcon(

                onTap: (){
              debugPrint("arrow back");
            },icon: Icons.arrow_back_ios_new_outlined),
            onClickIcon(size: 46,
                onTap: (){
              debugPrint("play");
            },icon: Icons.play_arrow),
            onClickIcon(onTap: (){
              debugPrint("arrow forward");
            },icon: Icons.arrow_forward_ios_outlined),
          ],
        )
      ],
    );
  }
  Widget onClickIcon({
    required IconData icon,
    final double size=28,
    required VoidCallback onTap,}){
    return  InkWell(
      onTap: onTap,
      child: Icon(icon ,color: primaryColor,size: size,),
    );
  }
}
