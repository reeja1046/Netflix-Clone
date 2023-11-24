import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_project/application/search/search_bloc.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/domain/core/debounce/debounce.dart';
import 'package:netflix_project/presentation/Search/widget/search_idel.dart';
import 'package:netflix_project/presentation/Search/widget/search_result.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});

  final _debouncer = Debouncer(milliseconds: 1 * 1000);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(const Initialize());
    });

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoSearchTextField(
            backgroundColor: Colors.grey,
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: Colors.grey[600],
            ),
            suffixIcon: Icon(
              CupertinoIcons.xmark_circle_fill,
              color: Colors.grey[600],
            ),
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              if (value.isEmpty) {
                return;
              }
              _debouncer.run(() {
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchMovie(movieQuery: value));
              });
            },
          ),
          kHeight,
          Expanded(child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.searchResultList.isEmpty) {
                return const SearchIdelWidget();
              } else {
                return const SearchResultWidget();
              }
            },
          )),
          //const Expanded(child:  SearchResultWidget()),
        ],
      ),
    )));
  }
}
