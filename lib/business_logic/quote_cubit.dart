import 'dart:convert';
import 'dart:io';

import 'package:altarifiappfinal/data/local/preference_helper.dart';
import 'package:altarifiappfinal/data/model/one_quote.dart';
import 'package:altarifiappfinal/data/model/quote.dart';
import 'package:altarifiappfinal/presentation/screens/favourite_screen.dart';
import 'package:altarifiappfinal/presentation/screens/list_screen.dart';
import 'package:altarifiappfinal/presentation/screens/main_screen.dart';
import 'package:altarifiappfinal/presentation/widgets/quotes_card.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit() : super(QuoteInitial());

  static QuoteCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(QuoteChangeModeState());
    } else {
      isDark = !isDark;
      SharedPreferenceHelper.putBoolean(key: 'isDark', value: isDark)
          .then((value) {
        emit(QuoteChangeModeState());
      });
    }
  }

  List<Quote> allQuotes = [];

  void getAllQuotes() {
    getJson().then((value) {
      allQuotes = value;
      emit(QuotesLoaded(allQuotes));
    }).catchError((error) {
      print('$error');
    });
  }

  Future<List<Quote>> getJson() async {
    return json
        .decode(await rootBundle.loadString('assets/quotes.json'))
        .map<Quote>((json) => new Quote.fromJson(json))
        .toList();
  }

  Future takeScreenShot(
      Widget widget, ScreenshotController screenshotController) async {
    await screenshotController
        .captureFromWidget(widget, delay: const Duration(milliseconds: 500))
        .then((image) async {
      final Directory directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(image);

      /// Share Plugin
      await Share.shareFiles([imagePath.path], text: 'Share from :');
    });
  }

  void getTakeScreenShot(text) {
    final controller = ScreenshotController();
    takeScreenShot(cardScreenShot(controller, text), controller)
        .then((value) => emit(QuoteShareScreenShot()));
  }

  int currentIndex = 0;
  List<Widget> screens = [MainScreen(), ListScreen(), FavouriteScreen()];

  void changeBottomNavBarIndex(index) {
    currentIndex = index;
    emit(QuoteChangeBottomNavBar());
  }

  late Database database;
  List<Map> favouriteQuotes = [];

  void createDatabase() {
    openDatabase('quote.dp', version: 1, onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE favourites (quote TEXT PRIMARY KEY, title TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('error when creating table $error');
      });
    }, onOpen: (database) {
      getFromDatabase(database);
      print('database opened');
    }).then((value) {
      database = value;
      emit(QuoteCreateDatabase());
    });
  }

  insertToDatabase({required String quote, required String title}) async {
    await database.transaction((txn) => txn
            .rawInsert(
                'INSERT OR REPLACE INTO favourites (quote,title) VALUES("$quote","$title")')
            .then((value) {
          print('$value inserted successfully');
          emit(QuoteInsertDatabase());
          getFromDatabase(database);
        }).catchError((error) {
          print('Error when insert new record $error');
        }));
  }

  void getFromDatabase(database) {
    favouriteQuotes = [];
    emit(QuoteGetDatabaseLoading());
    database.rawQuery('SELECT * FROM favourites').then((value) {
      value.forEach((element) {
        favouriteQuotes.add(element);
      });
      emit(QuoteGetDatabase());
    });
  }

  void deleteData({
    required String quote,
  }) async {
    database.rawDelete('DELETE FROM favourites WHERE quote = ?', [quote]).then(
        (value) {
      getFromDatabase(database);
      emit(QuoteDeleteDatabase());
    });
  }

  List<OneQuote> getAllQuotesAsQuote() {
    List<OneQuote> allQuotesAsQuote = [];
    allQuotes.forEach((quote) {
      quote.quotes.forEach((element) {
        allQuotesAsQuote.add(OneQuote(quote: element, title: quote.title));
      });
    });
    return allQuotesAsQuote;
  }


}
