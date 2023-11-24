import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/widgets/custom_button_widget.dart';
import '../../widgets/video_widgets.dart';

class EveryOnesWatching extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;

  const EveryOnesWatching({
    super.key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight,
         Text(
          movieName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight,
         Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          // "This hit sitcom follows the merry misadvantures of six 20- something pals as they navigate the pitfalls of works,life and love in 1990s Manhattam.",
          style: const TextStyle(
            color: kGreayColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight50,
         videoWidget(url: posterPath,),
        kHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CustomButtonWidget(
              icon: Icons.share,
              title: "Share",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth,
            CustomButtonWidget(
              icon: Icons.add,
              title: "My List",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth,
            CustomButtonWidget(
              icon: Icons.play_arrow,
              title: "Play",
              iconSize: 25,
              textSize: 16,
            ),
            kWidth
          ],
        )
      ],
    );
  }
}
