import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/paymentapi.dart';
import 'package:wisata_bali/models/list_payment_history_model.dart';

class ListTransactionHistoryPage extends StatefulWidget {
  const ListTransactionHistoryPage({super.key});

  @override
  State<ListTransactionHistoryPage> createState() =>
      _ListTransactionHistoryPageState();
}

class _ListTransactionHistoryPageState
    extends State<ListTransactionHistoryPage> {
  List<ListPaymentHistoryModel>? listPaymentHistory;
  var isLoaded = false;
  getListHistory() async {
    final prefs = await SharedPreferences.getInstance();
    var getString = prefs.getString('jwt');
    if (getString != null) {
      listPaymentHistory =
          await PaymentApi().getListPaymentHistory(getString.toString());
      if (listPaymentHistory!.isNotEmpty) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  void initState() {
    getListHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final currencyformatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Transaction History',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Visibility(
                      visible: isLoaded,
                      replacement:
                          const Center(child: Text('No Transaction History')),
                      child: Column(
                        children: List.generate(listPaymentHistory?.length ?? 0,
                            (index) {
                          var paymentCode =
                              listPaymentHistory![index].paymentCode;
                          var total = listPaymentHistory![index].total;
                          var status = listPaymentHistory![index].status;
                          var cartItems = listPaymentHistory![index].cartItems;
                          if (listPaymentHistory!.isNotEmpty) {
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: isDarkTheme
                                              ? Colors.white.withOpacity(0.14)
                                              : Colors.black12),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '#$paymentCode',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 100,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff38E54D),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              status,
                                              style: GoogleFonts.salsa(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          child: Column(
                                        children: List.generate(
                                            cartItems.length, (index) {
                                          var date = cartItems[index].date;
                                          var title = cartItems[index].name;
                                          var price = cartItems[index].price;
                                          var amount = cartItems[index].amount;
                                          var image =
                                              cartItems[index].images[0].img;
                                          var total = amount * int.parse(price);
                                          return Column(
                                            children: [
                                              const Divider(),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: isDarkTheme
                                                            ? Colors.white
                                                                .withOpacity(
                                                                    0.14)
                                                            : Colors.black12),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 120,
                                                          width: 120,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      'https://api-bali-journey.herokuapp.com/$image'),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    20,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                                  child: Text(
                                                                    title,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20,
                                                                        color: isDarkTheme
                                                                            ? Colors.white
                                                                            : const Color(0xff136068)),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    '${date.toLocal()}'
                                                                        .split(
                                                                            ' ')[0],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: isDarkTheme
                                                                            ? Colors.white
                                                                            : const Color(0xff136068)),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
                                                                        '$amount pax x ${currencyformatter.format(int.parse(price))}',
                                                                        style: TextStyle(
                                                                            color: isDarkTheme
                                                                                ? Colors.white
                                                                                : const Color(0xff136068),
                                                                            fontSize: 12,
                                                                            fontWeight: FontWeight.w100),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Text(
                                                                        currencyformatter
                                                                            .format(total),
                                                                        style: TextStyle(
                                                                            color: isDarkTheme
                                                                                ? Colors.white
                                                                                : const Color(0xff136068),
                                                                            fontSize: 18,
                                                                            fontWeight: FontWeight.w100),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: TextStyle(
                                                      color: isDarkTheme
                                                          ? Colors.white
                                                          : const Color(
                                                              0xff136068)),
                                                ),
                                                Text(
                                                  currencyformatter
                                                      .format(int.parse(total)),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else if (listPaymentHistory!.isEmpty) {
                            return const Center(
                                child: Text('No Transaction History'));
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
