// import 'package:altarifiappfinal/business_logic/quote_cubit.dart';
// import 'package:altarifiappfinal/data/model/one_quote.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var searchController = TextEditingController();
//     return BlocConsumer<QuoteCubit, QuoteState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = QuoteCubit.get(context);
//         return Scaffold(
//           appBar: AppBar(),
//           body: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: TextFormField(
//                     controller: searchController,
//                     validator: (v) {
//                       if (v == '') {
//                         return 'Search must not be empty';
//                       }
//                       return '';
//                     },
//                     onChanged: (value) =>
//                         cubit.getSearchQuotes(searchController.text),
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Search',
//                       prefixIcon: Icon(
//                         Icons.search,
//                       ),
//                     )),
//               ),
//               Expanded(
//                   child: ConditionalBuilder(
//                 condition: cubit.listAllSearch.length > 0,
//                 builder: (BuildContext context) {
//                   return buildList(cubit.listAllSearch);
//                 },
//                 fallback: (BuildContext context) {
//                   return Container();
//                   // buildList(cubit.getAllQuotesAsQuote());
//                 },
//               ))
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// Widget buildList(List<OneQuote> list) {
//   return ListView.separated(
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.only(right: 20, left: 5),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     list[index].quote,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w800,
//                       fontSize: 17,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     '" ${list[index].title} "',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontWeight: FontWeight.normal,
//                       fontSize: 15,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             QuoteCubit.get(context)
//                                 .getTakeScreenShot(list[index].quote);
//                           },
//                           icon: Icon(
//                             Icons.share_outlined,
//                           )),
//                       IconButton(
//                           onPressed: () {
//                             QuoteCubit.get(context)
//                                 .deleteData(quote: list[index].quote);
//                           },
//                           icon: Icon(
//                             Icons.delete_outline,
//                           )),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//       separatorBuilder: (context, index) {
//         return SizedBox(
//           height: 10,
//         );
//       },
//       itemCount: list.length);
// }
