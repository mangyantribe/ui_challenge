
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/PhotoViewerController.dart';

//ignore: must_be_immutable
class PhotoViewer extends StatelessWidget {
  //final List<String> photos;
  PhotoViewer({super.key});
  PhotoViewerController controller = Get.put(PhotoViewerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) => controller.selectedPhoto = index,
              height: Get.context!.height,
              viewportFraction: 1,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              scrollPhysics: const BouncingScrollPhysics()
            ),
            items: List.generate(controller.photos.length, (index) {
              var item = controller.photos[index];
              return CachedNetworkImage(
                fit: BoxFit.cover,
                height: 10,
                width: double.infinity,
                imageUrl: item,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(
                    width: Get.context!.width,
                    color: Colors.grey.shade300,
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error_outline,color: Colors.grey,),
                ),
              );
            }),
          ),
          Positioned(
            top: 45,
            left: 0,
            right: 320,
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 40,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                ),
                child: const Icon(Icons.arrow_back_outlined),
              ),
            ),
          ),
          Positioned(
            top: Get.context!.height - 50,
            left: 0,
            right: 0,
            child: Obx(() => DotsIndicator(
              dotsCount: controller.photos.length,
              position: controller.galleryCurrentIndex,
              decorator: DotsDecorator(
                color: Colors.white,
                spacing: const EdgeInsets.all(4.0),
                size: const Size.square(5.0),
                activeSize: const Size(15.0, 5.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                activeColors: List.generate(controller.photos.length,(index){
                  return const Color(0xFF44b7bf);
                }),
              ),
            )),
          )
        ],
      ),
    );
  }
}
