import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/widgets/custom_button_widget.dart';
import '../../widgets/video_widgets.dart';

class commingSoon extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const commingSoon({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                month,
                style: const TextStyle(
                  fontSize: 16,
                  color: kGreayColor,
                ),
              ),
              Text(
                day,
                style: const TextStyle(
                  fontSize: 30,
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              videoWidget(url: posterPath),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        // letterSpacing: -1,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const CustomButtonWidget(
                    icon: Icons.all_out_sharp,
                    title: "Remind Me",
                    iconSize: 20,
                    textSize: 12,
                  ),
                  kWidth,
                const  CustomButtonWidget(
                    icon: Icons.info,
                    title: "Info",
                    iconSize: 20,
                    textSize: 12,
                  ),
                  kWidth,
                ],
              ),
              kHeight,
              Text("Coming On $day $month"),
              kHeight,
              Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                maxLines: 4,
                // "Landing the lead in the school musical is a dream come true for Jodi,until the pressure send her confidence - and her relationship -  into a tailspain.",
                style: const TextStyle(
                  color: kGreayColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
