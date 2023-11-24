import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_project/application/downloads/downloads_bloc.dart';
import 'package:netflix_project/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_project/application/home/home_bloc.dart';
import 'package:netflix_project/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_project/application/search/search_bloc.dart';
import 'package:netflix_project/core/colors/colors.dart';
import 'package:netflix_project/domain/core/di/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_project/presentation/main%20page/screen_main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<DownloadsBloc>()),
        BlocProvider(create: (context) => getIt<SearchBloc>()),
        BlocProvider(create: (context) => getIt<FastLaughBloc>()),
        BlocProvider(create: (context) => getIt<HotAndNewBloc>()),
        BlocProvider(create: (context) => getIt<HomeBloc>()),
      ],
      child: MaterialApp(
        title: "Netflix-Clone ",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          scaffoldBackgroundColor: backgroundColor,
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        home: ScreenMainPage(),
      ),
    );
  }
}
