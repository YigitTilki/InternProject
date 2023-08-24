import 'package:flutter/material.dart';

import '../constants/constants.dart';

Container adminPageContainerDesign(String image, String text) {
  return Container(
    width: 152,
    height: 99,
    decoration: ShapeDecoration(
      color: const Color(0xCC7B00EB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(
            image,
            height: 70,
            width: 70,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            text,
            style: Constants.getTextStyle(Colors.white, 15.0),
          ),
        ),
      ],
    ),
  );
}

Padding areYouSureContainer(List<Widget> children) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.black.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        height: 250,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    ),
  );
}
