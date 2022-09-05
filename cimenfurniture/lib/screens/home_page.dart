import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            carouselController: controller,
            options: CarouselOptions(
                height: 400,
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
          const SizedBox(
            height: 25,
          ),
          buildIndicator()
        ],
      ),
    ));
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
