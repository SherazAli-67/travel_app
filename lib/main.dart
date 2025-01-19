import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/src/bloc_cubit/home_page_cubit/home_cubit.dart';
import 'package:travel_app/src/bloc_cubit/location_details_cubit/location_details_cubit.dart';
import 'package:travel_app/src/bloc_cubit/main_menu_bloc/main_menu_bloc.dart';
import 'package:travel_app/src/features/main_menu_page.dart';
import 'package:travel_app/src/providers/favorites_provider.dart';
import 'package:travel_app/src/res/app_colors.dart';

void main() async{
  await dotenv.load(fileName: 'assets/.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavLocationsProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> MainMenuTabChangeBloc()),
        BlocProvider(create: (_)=> HomeCubit()),
        BlocProvider(create: (_)=> LocationDetailsCubit())
      ],
      child: MaterialApp(
        title: 'Traver App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
          fontFamily: 'Poppins'
        ),
        home: const MainMenuPage()
      ),
    );
  }
}
