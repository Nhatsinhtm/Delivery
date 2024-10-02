import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlideImage extends StatefulWidget {
  const SlideImage({super.key});

  @override
  State<SlideImage> createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImage> {
  bool heart= true;
  int ActiveIndex=0;

  final urlImages = [
    'https://loremflickr.com/640/480/animals',
    'https://loremflickr.com/640/480/animals',
    'https://loremflickr.com/640/480/animals',
    'https://loremflickr.com/640/480/animals',
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        CarouselSlider.builder(
            itemCount: urlImages.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage=urlImages[index];
              return buildImage(urlImage, index);
            },
            options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  setState(() {
                    ActiveIndex=index;
                  });
                },
                disableCenter: true,
                viewportFraction: 1
            )),
        Positioned(
            top: MediaQuery.of(context).size.height*0.22,
            child: buildIndicator()),
      ],
    );
  }

//  build Widget for Slide
Widget buildIndicator()=>AnimatedSmoothIndicator(activeIndex: ActiveIndex, count: urlImages.length,
  effect:const WormEffect(
      dotHeight: 8,
      dotWidth: 8,
      activeDotColor: Colors.black54,
      dotColor: Colors.grey,
      spacing: 5
  ),
);
}
Widget buildImage(String urlImage, int index)
=>Container(
  color: Colors.blue,
  child: Image.network(urlImage,fit: BoxFit.cover,
  loadingBuilder:  (context, child, loadingProgress) {
    if(loadingProgress == null){
      return child;
    }
    else {
      return const Center(child:  CircularProgressIndicator());
    }
  },
  ),
);

