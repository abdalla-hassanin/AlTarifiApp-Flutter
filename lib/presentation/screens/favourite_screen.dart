import 'package:altarifiappfinal/business_logic/quote_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuoteCubit, QuoteState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = QuoteCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.favouriteQuotes.length>0,
          builder: (BuildContext context) {
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
                              cubit.favouriteQuotes[index]['quote'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              '" ${cubit.favouriteQuotes[index]['title']} "',
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
                                          .getTakeScreenShot(
                                          cubit.favouriteQuotes[index]['quote']);
                                    },
                                    icon: Icon(
                                      Icons.share_outlined,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      QuoteCubit.get(context).deleteData(
                                          quote: cubit
                                              .favouriteQuotes[index]['quote']);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
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
                itemCount: cubit.favouriteQuotes.length);
          },
          fallback: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Image.asset('assets/images/empty.gif'),
              ),
            );
          },

        );

      },
    );
  }
}
