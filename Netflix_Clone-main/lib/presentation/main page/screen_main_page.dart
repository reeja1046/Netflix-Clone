import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_project/presentation/Search/screen_search.dart';
import 'package:netflix_project/presentation/downloads/screen_downloads.dart';
import 'package:netflix_project/presentation/fast_laugh/screen_fast_laught.dart';
import 'package:netflix_project/presentation/home/screen_home.dart';
import 'package:netflix_project/presentation/main%20page/widgets/bottom.nav.dart';
import 'package:netflix_project/presentation/new_and_hot/screen_new_and_hot.dart';

import '../../core/colors/colors.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});

  final _pages = [
    ScreenHome(),
    ScreenNewAndHot(),
    ScreenFastLaugh(),
    ScreenSearch(),
    ScreenDownloads()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return _pages[index];
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
