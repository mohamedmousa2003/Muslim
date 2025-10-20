import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/model/sura_model.dart';

import '../../core/custom_text.dart';

class SuraDetails extends StatelessWidget {
  static const String routeName ="SuraDetails";
  const SuraDetails({super.key});
  @override
  Widget build(BuildContext context) {
    var mediaQuery =MediaQuery.of(context).size;
    var model = ModalRoute.of(context)?.settings.arguments as SuraModel ;
    return  Stack(
      children: [
        Image.asset(
          "assets/bg3.png",
          fit: BoxFit.fill,
          width: mediaQuery.width,
          height: mediaQuery.height,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(islam,style: GoogleFonts.elMessiri(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Colors.black
            ),),
          ),
          body: Center(
            child: Text(model.suraName,style: GoogleFonts.elMessiri(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Colors.black
            ),),
          ),
        ),
      ],
    );
  }
}
