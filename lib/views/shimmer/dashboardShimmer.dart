

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget dashboardShimmer() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade500,
      child: Column(
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 190,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black26,
                    ),
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}