import 'package:altarifiappfinal/business_logic/quote_cubit.dart';
import 'package:altarifiappfinal/constants/themes.dart';
import 'package:altarifiappfinal/presentation/layout/HomeLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/bloc_observer.dart';
import 'data/local/preference_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await SharedPreferenceHelper.init();
  bool? isDark = SharedPreferenceHelper.getBoolean(key: 'isDark');
  if (isDark == null) isDark = false;
  runApp(MyApp(isDark));
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     systemNavigationBarColor: MyColors.dark1,
  //     statusBarColor: MyColors.dark1,
  //     systemNavigationBarIconBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      QuoteCubit()
        ..getAllQuotes()
        ..createDatabase()
        ..changeAppMode(fromShared: isDark),
      child: BlocConsumer<QuoteCubit, QuoteState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: HomeLayout(),
            ),
            theme: appLiteTheme(),
            darkTheme: appDarkTheme(),
            themeMode:
            QuoteCubit
                .get(context)
                .isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
