import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_project/application/home/home_bloc.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/home/widgets/background_card.dart';
import 'package:netflix_project/presentation/home/widgets/number_title_card.dart';

import '../widgets/main_title_card.dart';

ValueNotifier<bool> ScrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: ScrollNotifier,
      builder: (context, index, _) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            // print(direction);
            if (direction == ScrollDirection.reverse) {
              ScrollNotifier.value = false;
            } else if (direction == ScrollDirection.forward) {
              ScrollNotifier.value = true;
            }

            return true;
          },
          child: Stack(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  } else if (state.hasError) {
                    return const Center(
                      child: Text(
                        "Error While Getting Data",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  // Released past year

                  final _releasesPastYear = state.pastYearMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  // Treanding
                  final _treanding = state.trendingMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  //  tense Dramas
                  final _tenseDramas = state.tenseDramaMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  //  South Indian Movies
                  final _southIndianMovies = state.pastYearMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();
                  _southIndianMovies.shuffle();

                  // Top 10 Tv Shows Number card
                  final _top10TvShows = state.trendingTvList.map((t) {
                    return '$imageAppendUrl${t.posterPath}';
                  }).toList();
                  _top10TvShows.shuffle();

                  // list Views
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView(
                      children: [
                        BackgroundCards(),
                        MainTitleCard(
                          title: "Released in the past year",
                          posterList: _releasesPastYear,
                        ),
                        kHeight,
                        MainTitleCard(
                          title: "Trending Now",
                          posterList: _treanding,
                        ),
                        kHeight,
                        NumberTitleCard(
                          postersList: _top10TvShows,
                        ),
                        kHeight,
                        MainTitleCard(
                          title: "Tense Dramas",
                          posterList: _tenseDramas,
                        ),
                        kHeight,
                        MainTitleCard(
                          title: "South Indian Cinema",
                          posterList: _southIndianMovies,
                        ),
                        kHeight,
                      ],
                    ),
                  );
                },
              ),
              ScrollNotifier.value == true
                  ? AnimatedContainer(
                      duration: const Duration(microseconds: 1000),
                      width: double.infinity,
                      height: 90,
                      color: Colors.black.withOpacity(0.3),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                "https://www.freepnglogos.com/uploads/netflix-logo-circle-png-5.png",
                                width: 60,
                                height: 60,
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
                          ),
                          // kHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "TV Shows",
                                style: khomeTitleText,
                              ),
                              Text(
                                "Movies",
                                style: khomeTitleText,
                              ),
                              Text(
                                "Categories",
                                style: khomeTitleText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : kHeight,
            ],
          ),
        );
      },
    ));
  }
}
