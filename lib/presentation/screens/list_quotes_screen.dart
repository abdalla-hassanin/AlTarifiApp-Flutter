import 'package:altarifiappfinal/business_logic/quote_cubit.dart';
import 'package:altarifiappfinal/data/model/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListQuotesScreen extends StatelessWidget {
  final Quote quote;

  ListQuotesScreen({required this.quote});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuoteCubit, QuoteState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  quote.title,
                  style: TextStyle(
                      fontFamily: 'asmaa',
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                      letterSpacing: 0),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                ),
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16, left: 6),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                quote.quotes[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
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
                                                quote.quotes[index]);
                                      },
                                      icon: Icon(
                                        Icons.share_outlined,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        QuoteCubit.get(context)
                                            .insertToDatabase(
                                                quote: quote.quotes[index],
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
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: quote.quotes.length)),
        );
      },
    );
  }
}
