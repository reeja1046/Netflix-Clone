import 'package:flutter/material.dart';
import 'package:netflix_project/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
        const Spacer(),
        const Icon(
          Icons.cast,
          color: Colors.white,
          size: 30,
        ),
        kWidth,
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://occ-0-2041-3662.1.nflxso.net/art/0d282/eb648e0fd0b2676dbb7317310a48f9bdc2b0d282.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        kWidth,
      ],
    );
  }
}
