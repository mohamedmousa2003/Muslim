import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/custom_color.dart';
import '../custom/divider.dart';
class HadithTabs extends StatelessWidget {
  const HadithTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Image.asset(
          "assets/hadeth_logo.png",
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
          child: ListView.separated(
            itemCount: 2,
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
                _AnimatedSuraItem(title: "", index: index),
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
    // Navigator.pushNamed(context, SuraDetails.routeName ,arguments: SuraModel(suraName: widget.title, index: widget.index));
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