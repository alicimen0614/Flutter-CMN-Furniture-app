import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = CarouselController();
  int activeIndex = 0;
  List<String> homePageImages = [
    'lib/images/banyo_1.jpeg',
    'lib/images/banyo_2.jpeg',
    'lib/images/fikret_cigdem.jpeg',
    'lib/images/dolap.jpeg',
    'lib/images/kaplamadolap.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("homepage çalıştı");
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                    carouselController: controller,
                    options: CarouselOptions(
                        height: height * 0.5,
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) => setState(
                              () => activeIndex = index,
                            )),
                    itemCount: homePageImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final homePageimage = homePageImages[index];

                      return buildImage(homePageimage, index);
                    },
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.0287,
                  ),
                  buildIndicator(),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.0115,
                  ),
                  Text("Bizi Instagram'dan takip edin.",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(fontSize: width * 0.051))),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            _launchUrl();
                          },
                          icon: const Icon(FontAwesomeIcons.instagram),
                          iconSize: width * 0.127,
                        ),
                        Text(
                          "|",
                          style: TextStyle(
                              fontSize: width * 0.127,
                              fontWeight: FontWeight.w100,
                              fontFamily: GoogleFonts.abel().fontFamily),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "CMN",
                          style: GoogleFonts.merriweather(
                              textStyle: TextStyle(fontSize: width * 0.063)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  final Uri url = Uri.parse('https://www.instagram.com/cmnmobilya/');
  Future<void> _launchUrl() async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Widget buildImage(String homePageimage, int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Image.asset(
        homePageimage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: homePageImages.length,
      onDotClicked: animateToSlide,
      effect: SlideEffect(
          dotWidth: 15,
          dotHeight: 15,
          dotColor: Colors.brown.shade500,
          activeDotColor: Colors.amberAccent.shade700),
    );
  }

  void animateToSlide(int index) => controller.animateToPage(index);
}
