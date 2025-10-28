import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/custom_color.dart';

import '../../../core/constant/images_assets.dart';

class SebhaTabs extends StatefulWidget {
  const SebhaTabs({super.key});

  @override
  State<SebhaTabs> createState() => _SebhaTabsState();
}

class _SebhaTabsState extends State<SebhaTabs> with SingleTickerProviderStateMixin {

  // قائمة الأذكار والعدد المستهدف
  final List<String> _adhkar =  [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله",
  ];

  // الهدف المطلوب الوصول إليه (العدد الابتدائي للتسبيح)
  final int _targetNumber = 33;

  // المؤشر الحالي للذكر في القائمة
  int _currentAdhkarIndex = 0;

  // العداد الحالي، يبدأ بالعدد المستهدف
  int _counter = 33;

  double _scale = 1.0;
  double _buttonScale = 1.0;

  // 1. الدالة المعدّلة للعد التنازلي وتغيير الذكر
  void _onTap() async {
    // 👈 تبدأ التغييرات في الواجهة (التكبير والتصغير)
    setState(() {
      _scale = 1.3;
      _buttonScale = 0.9;
    });

    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      _counter--;
      if (_counter < 1) {
        // 3. إعادة العداد إلى العدد المستهدف (33)
        _counter = _targetNumber;

        // 4. الانتقال إلى الذكر التالي في القائمة بشكل دائري
        _currentAdhkarIndex = (_currentAdhkarIndex + 1) % _adhkar.length;
      }

      _scale = 1.0;
      _buttonScale = 1.0;
    });
  }

  // دالة للحصول على الذكر الحالي
  String get _currentAdhkar => _adhkar[_currentAdhkarIndex];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: mediaQuery.height*0.07,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    " $_currentAdhkar",
                    style: GoogleFonts.elMessiri(
                      fontSize: 28,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  " الذكر الحالي",
                  style: GoogleFonts.elMessiri(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mediaQuery.height * 0.45,
              width: double.infinity,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final height = constraints.maxHeight;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      /// جسم السبحة (أسفل)
                      Positioned(
                        bottom: 0,
                        left: (constraints.maxWidth - (mediaQuery.width * 0.52)) / 2,
                        child: Image.asset(
                          ImagePngLight.bodySebha,
                          width: mediaQuery.width * 0.50,
                          fit: BoxFit.contain,
                        ),
                      ),

                      /// رأس السبحة (أعلى الجسم)
                      Positioned(
                        bottom: height * 0.56,
                        left: (constraints.maxWidth - (mediaQuery.width * 0.16)) / 2 + mediaQuery.width * 0.05,
                        child: Image.asset(
                          ImagePngLight.headSebha,
                          width: mediaQuery.width * 0.16,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: mediaQuery.height*0.02,),
            AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 26),
                color: primaryColor.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  child: Text(
                    "$_counter",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _onTap,
              child: AnimatedScale(
                scale: _buttonScale,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                child: Card(
                  color: primaryColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    child: Text(
                      _currentAdhkar,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}