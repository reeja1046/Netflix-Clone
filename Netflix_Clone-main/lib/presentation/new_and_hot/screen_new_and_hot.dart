import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_project/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_project/core/colors/colors.dart';
import 'package:netflix_project/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_project/presentation/new_and_hot/widget/coming_soon_widget.dart';
import 'package:netflix_project/presentation/new_and_hot/widget/everyones_watching_widgets.dart';
import 'package:netflix_project/presentation/widgets/app_bar_widget.dart';
import 'package:netflix_project/presentation/widgets/video_widgets.dart';
import 'package:intl/intl.dart';
import '../../core/constants.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              "New & hot",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: [
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
              kWidth20,
            ],
            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: kWhiteColor,
                labelColor: kBlackColor,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                indicator: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: kRadius30,
                ),
                tabs: const [
                  Tab(
                    text: "🍿 Coming Soon",
                  ),
                  Tab(
                    text: "👀 Everyone's Watching",
                  )
                ]),
          ),
        ),
        body: const TabBarView(
          children: [
            CommingSoonList(
              key: Key('coming soon'),
            ),
            EveryoneIsWatchingList(
              key: Key('everyone is watching'),
            ),
          ],
        ),
      ),
    );
  }
}

class CommingSoonList extends StatelessWidget {
  const CommingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInCommingSoon());
    });
    return RefreshIndicator(
      backgroundColor: Colors.black,
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInCommingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error while loading coming soon list"),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text("Coming soon is empty"),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemBuilder: (context, index) {
                final movie = state.comingSoonList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }
                log(movie.releaseDate.toString());
                String month = '';
                String date = '';
                try {
                  final _date = DateTime.tryParse(movie.releaseDate!);
                  final formatedDate =
                      DateFormat.yMMMMd('en_US').format(_date!);
                  log(formatedDate.toString());
                  month = formatedDate
                      .split(' ')
                      .first
                      .substring(0, 3)
                      .toUpperCase();
                  date = movie.releaseDate!.split('-')[1];
                } catch (_) {
                  month = '';
                  date = '';
                }

                return commingSoon(
                  id: movie.id.toString(),
                  month: month,
                  day: date,
                  posterPath: '$imageAppendUrl${movie.posterPath}',
                  movieName: movie.originalTitle ?? "No Title",
                  description: movie.overview ?? "No description",
                );
              },
              itemCount: state.comingSoonList.length,
            );
          }
        },
      ),
    );
  }
}

class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryOneIsWatching());
    });
    return RefreshIndicator(
      backgroundColor: Colors.black,
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryOneIsWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error while loading coming soon list"),
            );
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text("Coming soon is empty"),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.everyOneIsWatchingList.length,
              itemBuilder: (context, index) {
                final movie = state.everyOneIsWatchingList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }

                final tv = state.everyOneIsWatchingList[index];

                return EveryOnesWatching(
                  posterPath: '$imageAppendUrl${tv.posterPath}',
                  movieName: tv.originalName ?? "No Name Provided",
                  description: tv.overview ?? "No description",
                );
              },
            );
          }
        },
      ),
    );
  }
}
