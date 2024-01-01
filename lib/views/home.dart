
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/DashboardController.dart';
import 'details.dart';
import 'shimmer/dashboardShimmer.dart';

class Home extends StatelessWidget {
  Home({super.key});
  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6f7f9),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RefreshIndicator(
          onRefresh: controller.getPopularHouses,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/logo.png"),
                    Image.asset("assets/bell.png"),
                  ],
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  readOnly: true,
                  decoration: buildInputDecoration('Search Here...'),
                  onTap: () => {},
                ),
                const SizedBox(height: 30,),
                Stack(
                  children: [
                    Container(
                      height: 150,
                      //width: 20,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                        image: DecorationImage(
                          image: Image.network('https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.luminosity),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lets buy a house here',style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold))),
                          const SizedBox(height: 70,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Discount 10%',style: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w600))),
                              Text('01 January 2024',style: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w600))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Obx((){
                  if(controller.isLoading){
                    return dashboardShimmer();
                  }else{
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: controller.upperHouses.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 15,
                            mainAxisExtent: 200,
                            crossAxisCount: 1
                        ),
                        itemBuilder: (context,index){
                          var upperHouse = controller.upperHouses[index];
                          return InkWell(
                            onTap: () => Get.to(() => Details(house: upperHouse,)),
                            child: Stack(
                              children: [
                                Hero(
                                  tag: upperHouse.tag.toString(),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black12,
                                      image: DecorationImage(
                                        image: Image.network(upperHouse.photo.toString()).image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 120,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                        child: SizedBox(
                                          // height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(upperHouse.address.toString(),style: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600))),
                                                    Container(
                                                      height: 30,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.rectangle,
                                                        borderRadius: BorderRadius.circular(25.0),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          const Icon(Icons.star,color: Colors.amber,size: 15),
                                                          Text(upperHouse.rating.toString(), overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(color: Colors.black),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('\$ ${upperHouse.price}/mo',style: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w600))),
                                                    Text(upperHouse.size.toString(),style: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w600))),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          );
                        }
                    );
                  }
                }),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Popular today',style: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Other',style: GoogleFonts.montserrat(textStyle: const TextStyle(color: Color(0xFF44b7bf),fontWeight: FontWeight.w600))),
                        const Icon(Icons.keyboard_arrow_down,color: Color(0xFF44b7bf),),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Obx((){
                  if(controller.isLoading){
                    return dashboardShimmer();
                  }else{
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: controller.houses.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 15,
                            mainAxisExtent: 200,
                            crossAxisCount: 1
                        ),
                        itemBuilder: (context,index){
                          var house = controller.houses[index];
                          return InkWell(
                            onTap: () => Get.to(() => Details(house: house,)),
                            child: Stack(
                              children: [
                                Hero(
                                  tag: house.tag.toString(),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black12,
                                      image: DecorationImage(
                                        image: Image.network(house.photo.toString()).image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 120,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                        child: SizedBox(
                                          // height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(house.address.toString(),style: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600))),
                                                    Container(
                                                      height: 30,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.rectangle,
                                                        borderRadius: BorderRadius.circular(25.0),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          const Icon(Icons.star,color: Colors.amber,size: 15),
                                                          Text(house.rating.toString(), overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(color: Colors.black),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('\$ ${house.price}/mo',style: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w600))),
                                                    Text(house.size.toString(),style: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w600))),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          );
                        }
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String label) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
              color: Color(0xFF44b7bf)
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: const Icon(Icons.search_outlined,color: Color(0xFF898889),),
        filled: true,
        fillColor: Colors.white,
        hintText: label,
    );
  }
}
