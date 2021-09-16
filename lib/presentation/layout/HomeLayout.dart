import 'package:altarifiappfinal/business_logic/quote_cubit.dart';
import 'package:altarifiappfinal/data/model/one_quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_page/search_page.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuoteCubit, QuoteState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = QuoteCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'ذخائر في سطور',
              style: TextStyle(
                  fontFamily: 'asmaa',
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  letterSpacing: 0),
              maxLines: 1,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SearchScreen(),
                    //   ),
                    // );

                    showSearch(
                      context: context,
                      delegate: SearchPage<OneQuote>(
                        items: cubit.getAllQuotesAsQuote(),
                        searchLabel: 'البحث',
                        suggestion: Directionality(
                            textDirection: TextDirection.rtl,
                            child: buildList(cubit.getAllQuotesAsQuote())),
                        failure: Center(
                          child: Text('لا يوجد نتيجة'),
                        ),
                        filter: (quote) => [quote.quote],
                        builder: (quote) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 5),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      quote.quote,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '" ${quote.title} "',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              QuoteCubit.get(context)
                                                  .getTakeScreenShot(
                                                      quote.quote);
                                            },
                                            icon: Icon(
                                              Icons.share_outlined,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              QuoteCubit.get(context).insertToDatabase(
                                                  quote: quote.quote,
                                                  title: quote.title);
                                            },
                                            icon: Icon(
                                              Icons.favorite_border_outlined,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search_outlined,
                  )),
              IconButton(
                  onPressed: () {
                    cubit.changeAppMode();
                  },
                  icon: Icon(
                    cubit.isDark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                  )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            showUnselectedLabels: false,
            onTap: (index) {
              cubit.changeBottomNavBarIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_outlined), label: 'القائمة'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined), label: 'المفضلة')
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}

Widget buildList(List<OneQuote> list) {
  return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 20, left: 5),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    list[index].quote,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '" ${list[index].title} "',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            QuoteCubit.get(context)
                                .getTakeScreenShot(list[index].quote);
                          },
                          icon: Icon(
                            Icons.share_outlined,
                          )),
                      IconButton(
                          onPressed: () {
                            QuoteCubit.get(context).insertToDatabase(
                                quote: list[index].quote,
                                title: list[index].title);
                          },
                          icon: Icon(
                            Icons.favorite_border_outlined,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: list.length);
}
