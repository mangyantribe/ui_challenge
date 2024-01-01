
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6f7f9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  Image.asset("assets/logo.png"),
                  const SizedBox(height: 40,),
                  RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'Looking', style: TextStyle(fontSize: 40,color: Color(0xFF44b7bf),fontWeight: FontWeight.bold)),
                        TextSpan(text: ' for an', style: TextStyle(fontSize: 40,color: Color(0xFFf3a916),fontWeight: FontWeight.bold)),
                        TextSpan(text: ' elegant house this is the place', style: TextStyle(fontSize: 40,color: Colors.black,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text('Welcome friends, are you looking for us?',style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 20,color: Color(0xFF898889),fontWeight: FontWeight.w500))),
                  const SizedBox(height: 20,),
                  Text('Congratulations you found us.',style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 20,color: Color(0xFF898889),fontWeight: FontWeight.w500))),
                  const SizedBox(height: 20,),
                  InkWell(
                      onTap: () => Get.toNamed('/dashboard'),
                      child: Image.asset("assets/next.png")
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Image.asset("assets/house.png"),
          ],
        ),
      ),
    );
  }
}
