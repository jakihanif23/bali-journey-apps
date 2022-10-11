import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/paymentapi.dart';
import 'package:wisata_bali/models/list_payment_unpaid_model.dart';

import 'choose_payment_bank.dart';
import 'get_detail_payment.dart';

class PaymentListsPage extends StatefulWidget {
  const PaymentListsPage({super.key});

  @override
  State<PaymentListsPage> createState() => _PaymentListsPageState();
}

class _PaymentListsPageState extends State<PaymentListsPage> {
  List<ListPaymentUnpaidModel>? listPaymentUnpaid;
  var isLoaded = false;
  getListPayment() async {
    var prefs = await SharedPreferences.getInstance();
    var getString = prefs.getString('jwt');
    if (getString != null) {
      listPaymentUnpaid =
          await PaymentApi().getListUnpaid(getString.toString());
      if (listPaymentUnpaid!.isNotEmpty) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  deletePayment(String id) async {
    final String apiUrl =
        'https://api-bali-journey.herokuapp.com/users/payments/unpaids/$id';
    final prefs = await SharedPreferences.getInstance();
    final getString = prefs.getString('jwt');
    var response = await http.delete(Uri.parse(apiUrl),
        headers: {'access_token': getString.toString()});
    if (response.statusCode == 200) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Payment Success'),
            content: const Text('Delete Payment Has Been Success'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        },
      );
    } else {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Payment Failed'),
            content: const Text('Delete Payment Error Encountered'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    getListPayment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final currencyformatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 16, 0, 0),
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
                          'Payment Lists',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(
                    child: Visibility(
                  visible: isLoaded,
                  replacement: const Center(
                    child: Text('No Payment Data'),
                  ),
                  child: ListView.builder(
                    itemCount: listPaymentUnpaid?.length,
                    itemBuilder: (context, index) {
                      var paymentCode = listPaymentUnpaid![index].paymentCode;
                      var total = listPaymentUnpaid![index].total;
                      var status = listPaymentUnpaid![index].status;
                      var cartItems = listPaymentUnpaid![index].cartItems;
                      var id = listPaymentUnpaid![index].id;
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
                                          color: status == 'unpaid'
                                              ? const Color.fromARGB(
                                                  255, 255, 44, 44)
                                              : const Color(0xffD9D9D9),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        status == 'unpaid'
                                            ? 'Unpaid'
                                            : status == 'pending'
                                                ? 'Pending'
                                                : '',
                                        style: GoogleFonts.salsa(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    child: Column(
                                  children:
                                      List.generate(cartItems.length, (index) {
                                    var date = cartItems[index].date;
                                    var title = cartItems[index].name;
                                    var price = cartItems[index].price;
                                    var amount = cartItems[index].amount;
                                    var image = cartItems[index].images[0].img;
                                    var total = amount * int.parse(price);
                                    return Column(
                                      children: [
                                        const Divider(),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: isDarkTheme
                                                      ? Colors.white
                                                          .withOpacity(0.14)
                                                      : Colors.black12),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 120,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                'https://api-bali-journey.herokuapp.com/$image'),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 0, 0, 0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            child: Text(
                                                              title,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                  color: isDarkTheme
                                                                      ? Colors
                                                                          .white
                                                                      : const Color(
                                                                          0xff136068)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              '${date.toLocal()}'
                                                                  .split(
                                                                      ' ')[0],
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: isDarkTheme
                                                                      ? Colors
                                                                          .white
                                                                      : const Color(
                                                                          0xff136068)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  '$amount pax x ${currencyformatter.format(int.parse(price))}',
                                                                  style: TextStyle(
                                                                      color: isDarkTheme
                                                                          ? Colors
                                                                              .white
                                                                          : const Color(
                                                                              0xff136068),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w100),
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  currencyformatter
                                                                      .format(
                                                                          total),
                                                                  style: TextStyle(
                                                                      color: isDarkTheme
                                                                          ? Colors
                                                                              .white
                                                                          : const Color(
                                                                              0xff136068),
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w100),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        deletePayment(id.toString());
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffFC700C),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          'Cancel Payment',
                                          style: GoogleFonts.salsa(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                    : const Color(0xff136068)),
                                          ),
                                          Text(
                                            currencyformatter
                                                .format(int.parse(total)),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          status == 'unpaid'
                                              ? InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        CupertinoPageRoute(
                                                            builder: (builder) =>
                                                                ChoosePaymentBank(
                                                                  id: id
                                                                      .toString(),
                                                                )));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: 129,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffF7FC0C),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Text(
                                                      'Payment',
                                                      style: GoogleFonts.salsa(
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        CupertinoPageRoute(
                                                            builder: (builder) =>
                                                                GetDetailPaymentPage(
                                                                    id: id
                                                                        .toString())));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: 129,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffF7FC0C),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Text(
                                                      'Pay Now',
                                                      style: GoogleFonts.salsa(
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                )
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
                    },
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
