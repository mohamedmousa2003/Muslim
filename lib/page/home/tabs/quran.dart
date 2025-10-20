import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/custom_color.dart';
import 'package:muslim/model/sura_model.dart';
import '../custom/divider.dart';
import '../sura_details.dart';

class QuranTabs extends StatelessWidget {
  const QuranTabs({super.key});

  static const List<String> suraNames = [
    "الفاتحة", "البقرة", "آل عمران", "النساء", "المائدة", "الأنعام",
    "الأعراف", "الأنفال", "التوبة", "يونس", "هود", "يوسف", "الرعد",
    "إبراهيم", "الحجر", "النحل", "الإسراء", "الكهف", "مريم", "طه",
    "الأنبياء", "الحج", "المؤمنون", "النور", "الفرقان", "الشعراء",
    "النمل", "القصص", "العنكبوت", "الروم", "لقمان", "السجدة",
    "الأحزاب", "سبأ", "فاطر", "يس", "الصافات", "ص", "الزمر", "غافر",
    "فصلت", "الشورى", "الزخرف", "الدخان", "الجاثية", "الأحقاف",
    "محمد", "الفتح", "الحجرات", "ق", "الذاريات", "الطور", "النجم",
    "القمر", "الرحمن", "الواقعة", "الحديد", "المجادلة", "الحشر",
    "الممتحنة", "الصف", "الجمعة", "المنافقون", "التغابن", "الطلاق",
    "التحريم", "الملك", "القلم", "الحاقة", "المعارج", "نوح", "الجن",
    "المزمل", "المدثر", "القيامة", "الإنسان", "المرسلات", "النبأ",
    "النازعات", "عبس", "التكوير", "الإنفطار", "المطففين", "الانشقاق",
    "البروج", "الطارق", "الأعلى", "الغاشية", "الفجر", "البلد", "الشمس",
    "الليل", "الضحى", "الشرح", "التين", "العلق", "القدر", "البينة",
    "الزلزلة", "العاديات", "القارعة", "التكاثر", "العصر", "الهمزة",
    "الفيل", "قريش", "الماعون", "الكوثر", "الكافرون", "النصر", "المسد",
    "الإخلاص", "الفلق", "الناس"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/quran_image.png",
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error, color: primaryColor, size: 40),
        ),
        const SizedBox(height: 10),
        const DividerCustom(),
        Text(
          "سور القرآن الكريم",
          style: GoogleFonts.elMessiri(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        const DividerCustom(),
        Expanded(
          child: ListView.separated(
            itemCount: suraNames.length,
            separatorBuilder: (_, __) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: const [
                  Icon(Icons.star_border, color: primaryColor),
                  Expanded(child: DividerCustom(thickness: 2)),
                  Icon(Icons.star_border, color: primaryColor),
                ],
              ),
            ),
            itemBuilder: (context, index) =>
                _AnimatedSuraItem(title: suraNames[index], index: index),
          ),
        ),
      ],
    );
  }
}

class _AnimatedSuraItem extends StatefulWidget {
  final String title;
  final int index;

  const _AnimatedSuraItem({required this.title, required this.index});
  @override
  State<_AnimatedSuraItem> createState() => _AnimatedSuraItemState();
}

class _AnimatedSuraItemState extends State<_AnimatedSuraItem>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  double _opacity = 1.0;

  void _animateTap() async {
    setState(() {
      _scale = 0.8;
      _opacity = 0.5;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _scale = 1.0;
      _opacity = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 200));
   Navigator.pushNamed(context, SuraDetails.routeName ,arguments: SuraModel(suraName: widget.title, index: widget.index));
    debugPrint("Pressed: ${widget.title}");
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: _animateTap,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 150),
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
