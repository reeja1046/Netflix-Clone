import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_project/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/domain/downloads/models/downloads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../../../core/colors/colors.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget({
    super.key,
    required this.widget,
    required this.movieData,
  }) : super(child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = dummyvideoUrls[index % dummyvideoUrls.length];
    return Stack(children: [
      FastLaughVideoPlayer(
        videoUrl: videoUrl,
        onStateChanged: (bool) {},
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side..............................................
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black.withOpacity(0.5),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.volume_off,
                  ),
                ),
              ),
              // Right side..................................................
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: posterPath == null
                          ? null
                          : NetworkImage('$imageAppendUrl$posterPath'),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: likedVideosIdsNotifier,
                    builder:
                        (BuildContext c, Set<int> newLikedListIds, Widget? _) {
                      final _index = index;
                      if (newLikedListIds.contains(_index)) {
                        return GestureDetector(
                          onTap: () {
                            // BlocProvider.of<FastLaughBloc>(context).add(
                            //   UnlikedVideo(id: _index),
                            // );
                            likedVideosIdsNotifier.value.remove(_index);
                            likedVideosIdsNotifier.notifyListeners();
                          },
                          child: const VideoActionsWidget(
                            icon: Icons.favorite_outline,
                            title: "Liked",
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          // BlocProvider.of<FastLaughBloc>(context).add(
                          //   LikedVideo(id: _index),
                          // );
                          likedVideosIdsNotifier.value.add(_index);
                          likedVideosIdsNotifier.notifyListeners();
                        },
                        child: const VideoActionsWidget(
                          icon: Icons.emoji_emotions,
                          title: "LOL",
                        ),
                      );
                    },
                  ),
                  const VideoActionsWidget(icon: Icons.add, title: "My List"),
                  GestureDetector(
                    onTap: () {
                      final movieName = VideoListItemInheritedWidget.of(context)
                          ?.movieData
                          .title;
                      if (movieName != null) {
                        Share.share(movieName);
                      }
                    },
                    child: const VideoActionsWidget(
                      icon: Icons.share,
                      title: "Share",
                    ),
                  ),
                  const VideoActionsWidget(
                      icon: Icons.play_arrow, title: "Play"),
                ],
              ),
            ],
          ),
        ),
      )
    ]);
  }
}

class VideoActionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionsWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          Text(
            title,
            style: const TextStyle(
              color: kWhiteColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.onStateChanged,
  });

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
            : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ));
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
