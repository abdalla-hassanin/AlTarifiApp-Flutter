import 'package:altarifiappfinal/business_logic/quote_cubit.dart';
import 'package:altarifiappfinal/presentation/widgets/quotes_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuoteCubit, QuoteState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  buildQuotesCard(context,
                      QuoteCubit.get(context).allQuotes[index]),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 20,
              );
            },
            itemCount: QuoteCubit.get(context).allQuotes.length);
      },
    );
  }
}
