import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_project/core/colors/colors.dart';
import 'package:bordered_text/bordered_text.dart';
import '../../../core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({
    super.key,
    required this.index,
    required this.imageUrl,
  });

  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 50,
              height: 200,
            ),
            Container(
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: kRadius10,
                image:  DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    imageUrl
                  )
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 13,
          bottom: -30,
          child: BorderedText(
            strokeWidth: 10.0,
            strokeColor: kWhiteColor,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                color: kBlackColor,
                fontWeight: FontWeight.bold,
                fontSize: 150,
                decoration: TextDecoration.none,
                // decorationColor: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
