import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/model/hadith_model.dart';

import '../../core/constant/images_assets.dart';
import '../../core/custom_text.dart';

class HadithDetails extends StatefulWidget {
  static const String routeName = "HadithDetails";
  const HadithDetails({super.key});

  @override
  State<HadithDetails> createState() => _HadithDetailsState();
}

class _HadithDetailsState extends State<HadithDetails> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final model = ModalRoute.of(context)!.settings.arguments as HadithModel;

    return Stack(
      children: [
        Image.asset(
          ImagePngLight.background,
          fit: BoxFit.cover,
          width: mediaQuery.width,
          height: mediaQuery.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              islam,
              style: GoogleFonts.elMessiri(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Container(
              width: mediaQuery.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromRGBO(255, 255, 255, 0.9),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    model.hadithName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.elMessiri(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: const Color(0xFF6B4D36),
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                    color: Color(0xFF6B4D36),
                    indent: 30,
                    endIndent: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.content.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            model.content[index],
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.amiri(
                              fontWeight: FontWeight.w400,
                              fontSize: 22,
                              height: 2.0,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
