import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/page/home/tabs/hadeth.dart';
import 'package:muslim/page/home/tabs/quran.dart';
import 'package:muslim/page/home/tabs/radio.dart';
import 'package:muslim/page/home/tabs/sebha.dart';
import 'package:muslim/page/home/tabs/setting.dart';
import '../../core/constant/images_assets.dart';
import '../../core/custom_color.dart';
import '../../core/custom_text.dart';
class HomeScreen extends StatefulWidget {
  static const String routNAme= "Home";
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int selectIndex =0;
  @override
  Widget build(BuildContext context) {
    var mediaQuery =MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          ImagePngLight.background,
          fit: BoxFit.fill,
          width: mediaQuery.width,
          height: mediaQuery.height,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(islam,style: GoogleFonts.elMessiri(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Colors.black
            ),),
          ),
          bottomNavigationBar: BottomNavigationBar(
            // type: BottomNavigationBarType.fixed,
            currentIndex: selectIndex,
              onTap:(value) => setState(() => selectIndex = value),
              backgroundColor: primaryColor,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.white,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                    backgroundColor: primaryColor,
                    icon:  const ImageIcon(AssetImage(ImagePngLight.quranICon)),label:quran),
                BottomNavigationBarItem(
                    backgroundColor: primaryColor,
                    icon: const ImageIcon(AssetImage(ImagePngLight.sebhaICon)),label:sebha),
                BottomNavigationBarItem(
                    backgroundColor: primaryColor,
                    icon: const ImageIcon(AssetImage(ImagePngLight.hadithICon)),label:hadith),
                BottomNavigationBarItem(
                    backgroundColor: primaryColor,
                    icon: const ImageIcon(AssetImage(ImagePngLight.radioICon)),label:radio),
                BottomNavigationBarItem(
                    backgroundColor: primaryColor,
                    icon: const Icon(Icons.settings),label:setting),
              ]
          ),
          body: SafeArea(
            child: IndexedStack(
              index: selectIndex,
              children: tabs,
            ),
          ),
        ),
      ],
    );
  }
  final List<Widget> tabs = [
    QuranTabs(),
    SebhaTabs(),
    HadithTabs(),
    RadioTabs(),
    SettingTabs(),
  ];
}
