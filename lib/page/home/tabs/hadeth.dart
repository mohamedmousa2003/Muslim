import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/images_assets.dart';
import '../../../core/custom_color.dart';
import '../../../model/hadith_model.dart';
import '../custom/divider.dart';
import '../hadith_details.dart';

class HadithTabs extends StatefulWidget {
  const HadithTabs({super.key});

  @override
  State<HadithTabs> createState() => _HadithTabsState();
}

class _HadithTabsState extends State<HadithTabs> {
  List<HadithModel> allHadith = [];

  @override
  void initState() {
    super.initState();
    loadHadithFile();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          ImagePngLight.hadith,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error, color: primaryColor, size: 40),
        ),
        const SizedBox(height: 10),
        const DividerCustom(),
        Text(
          "الأحاديث",
          style: GoogleFonts.elMessiri(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        const DividerCustom(),
        Expanded(
          child: allHadith.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
            itemCount: allHadith.length,
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
            itemBuilder: (context, index) => _AnimatedSuraItem(
              title: allHadith[index].hadithName,
              hadith: allHadith[index], // ✅ أرسل الحديث هنا
            ),
          ),
        ),
      ],
    );
  }

  Future<void> loadHadithFile() async {
    final file = await rootBundle.loadString("assets/files/ahadeth.txt");
    List<String> hadithList = file.split("#");
    allHadith.clear();
    for (var h in hadithList) {
      List<String> lines = h.trim().split("\n");
      if (lines.isEmpty) continue;
      String title = lines.first;
      lines.removeAt(0);
      List<String> content = lines;
      allHadith.add(HadithModel(title, content));
    }

    setState(() {});
  }
}

class _AnimatedSuraItem extends StatefulWidget {
  final String title;
  final HadithModel hadith;

  const _AnimatedSuraItem({
    required this.title,
    required this.hadith,
  });

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

    Navigator.pushNamed(
      context,
      HadithDetails.routeName,
      arguments: widget.hadith, // ✅ استخدم الحديث اللي اتبعت
    );

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
