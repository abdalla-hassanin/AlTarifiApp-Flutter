import 'package:altarifiappfinal/business_logic/quote_cubit.dart';
import 'package:altarifiappfinal/data/model/quote.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

Widget buildQuotesCard(context, Quote quote) {
  return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quote.title,
            style: TextStyle(
                fontFamily: 'asmaa',
                fontWeight: FontWeight.normal,
                fontSize: 24,
                letterSpacing: 0),
            textAlign: TextAlign.end,
          ),
          ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    QuoteCubit.get(context)
                                        .getTakeScreenShot(quote.quotes[index]);
                                  },
                                  icon: Icon(
                                    Icons.share_outlined,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    QuoteCubit.get(context).insertToDatabase(
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
                  height: 20,
                );
              },
              itemCount: quote.quotes.length)
        ],
      ));
}

Widget cardScreenShot(controller, String text) {
  return Screenshot(
      child: Container(
        width: 325,
        height: 325,
        child: Card(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/image1.jpg',
                height: 325,
                width: 325,
                fit: BoxFit.fill,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 80, 16, 24),
                  child: AutoSizeText(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF6F4C5B),
                        fontFamily: 'asmaa',
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      controller: controller);
}
