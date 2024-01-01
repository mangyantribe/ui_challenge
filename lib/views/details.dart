
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../controllers/DetailsController.dart';
import '../models/House.dart';
import 'photo_viewer.dart';

class Details extends StatelessWidget {
  final House house;
  Details({super.key, required this.house});
  DetailsController controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              Column(
                children: [
                  Hero(
                    tag: house.tag.toString(),
                    child: Container(
                      height: 400,
                      //width: 20,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image: Image.network(house.photo.toString()).image,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.luminosity),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBar.builder(
                          itemSize: 25,
                          initialRating: house.rating!,
                          minRating: 1,
                          itemCount: 5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          unratedColor: Colors.amber.withAlpha(50),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(house.address.toString(),style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 23,color: Colors.black),fontWeight: FontWeight.bold)),
                            Obx((){
                              if(controller.isFavorite.isTrue){
                                return IconButton(
                                  icon: const Icon(Icons.favorite,color: Color(0xFF44b7bf),),
                                  onPressed: () => controller.tagAsFavorite = controller.isFavorite.value ,
                                );
                              }else{
                                return IconButton(
                                  icon: const Icon(Icons.favorite_border_outlined,color: Color(0xFF44b7bf)),
                                  onPressed: () => controller.tagAsFavorite = controller.isFavorite.value ,
                                );
                              }
                            }),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Text('Description',style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 20,color: Colors.black),fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10,),
                        ReadMoreText(
                          house.description.toString(),
                          textAlign: TextAlign.justify,
                          trimLines: 4,
                          colorClickableText: const Color(0xFF44b7bf),
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Read more',
                          trimExpandedText: ' Less',
                          style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 18,color: Color(0xFF898889),fontWeight: FontWeight.w400)),
                          moreStyle: const TextStyle(fontSize: 15,color: Color(0xFF44b7bf),fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20,),
                        Image.network('https://www.google.com/maps/d/thumbnail?mid=1SGV05OIEKGV2k2aKkDy8fxbwFtY&hl=en_US'),
                      ],
                    ),
                  ),
                ],
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
                top: 100,
                left: 280,
                right: 0,
                child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: house.thumbnails!.length > 3 ? 3 : house.thumbnails!.length,
                    itemBuilder: (context,index){
                      var photo = house.thumbnails![index];
                      return _buildThumbnails(index,house.thumbnails!,photo);
                    }
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price',style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 16,color: Colors.black))),
                    Text('\$ ${house.price}',style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 20,color: Colors.black),fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => {},
                        style: ButtonStyle(
                          //backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF44b7bf)),
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: const BorderSide(color: Colors.white)
                                )
                            )
                        ),
                        child:  const Text('Pay Now',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 16)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildThumbnails(int index,List<String> thumbnail,String photo) {
    return Column(
      children: [
        InkWell(
          onTap: () => Get.toNamed('/photos',arguments: thumbnail),
          child: Stack(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: Image.network(photo).image,
                        fit: BoxFit.cover,
                        colorFilter: thumbnail.length > 3 ? index > 1 ? ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.luminosity) : null : null,
                    )
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(child: thumbnail.length > 3 ? index > 1 ? Text('+${thumbnail.length - 3}',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20.0),) : null : null )
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,)
      ],
    );
  }
}


