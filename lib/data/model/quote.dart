

class Quote {
  Quote({
    required this.title,
    required this.quotes,
  });

  String title;
  List<String> quotes;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        title: json["title"],
        quotes: List<String>.from(json["quotes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "quotes": List<dynamic>.from(quotes.map((x) => x)),
      };
}
