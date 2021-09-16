part of 'quote_cubit.dart';

@immutable
abstract class QuoteState {}

class QuoteInitial extends QuoteState {}
class QuoteChangeModeState extends QuoteState {}


class QuotesLoaded extends QuoteState {
  final List<Quote> allQuotes;

  QuotesLoaded(this.allQuotes);
}
class QuoteShareScreenShot extends QuoteState {}
class QuoteChangeBottomNavBar extends QuoteState {}


class QuoteCreateDatabase extends QuoteState {}
class QuoteGetDatabaseLoading extends QuoteState {}

class QuoteInsertDatabase extends QuoteState {}

class QuoteUpdateDatabase extends QuoteState {}

class QuoteDeleteDatabase extends QuoteState {}

class QuoteGetDatabase extends QuoteState {}

class QuoteGetSearch extends QuoteState {}

