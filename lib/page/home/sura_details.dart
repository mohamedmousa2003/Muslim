import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/constant/images_assets.dart';
import 'package:muslim/core/custom_text.dart';
import 'package:muslim/model/sura_model.dart';
import 'custom/divider.dart';

class SuraDetails extends StatefulWidget {
  static const String routeName = "SuraDetails";
  const SuraDetails({super.key});
  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}
class _SuraDetailsState extends State<SuraDetails> {
  List<String> verses = [];
  bool isLoading = true;
  late SuraModel model;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      model = args as SuraModel;

      loadSuraFile(model.index);
    });
  }

  Future<void> loadSuraFile(int index) async {
    try {
      String file = await rootBundle.loadString("assets/files/${index + 1}.txt");

      List<String> suraLines = file.split("\n");

      setState(() {
        verses = suraLines;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading sura file: $e");
      setState(() {
        isLoading = false;
        verses = ["حدث خطأ في تحميل السورة. تأكد من مسار الملف."];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
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

                  if (!isLoading)
                    Text(
                      model.suraName,
                      style: GoogleFonts.elMessiri(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: const Color(0xFF6B4D36),
                      ),
                    ),

                  DividerCustom(thickness: 1.5, color: const Color(0xFF6B4D36)),

                  if (isLoading)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF6B4D36),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Scrollbar(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: ListView.builder(
                            itemCount: verses.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: SelectableText(
                                  '${verses[index]} ﴿${index + 1}﴾',
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
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}