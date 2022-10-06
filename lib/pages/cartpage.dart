import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/cartapi.dart';
import 'package:wisata_bali/models/cart_model.dart';
import 'package:wisata_bali/widgets/buttonyellow.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final currencyformatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');
  Future<CartModel>? futureCart;
  var loginChecker = false;
  updateToPayment(Map payload) async {
    final prefs = await SharedPreferences.getInstance();
    const String apiUrl =
        'https://api-bali-journey.herokuapp.com/users/payments/carts';
    final getString = prefs.getString('jwt');
    var response = await http.put(Uri.parse(apiUrl),
        headers: {'access_token': getString.toString()}, body: payload);
    if (response.statusCode == 200) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Updated'),
            content: const Text('Your Items Has been added to Payment'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text('OK'))
            ],
          );
        },
      );
    } else if (response.statusCode == 404) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Failed'),
            content: const Text('Data Cart not Found'),
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
    } else if (response.statusCode == 203) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Failed'),
            content: const Text('Invalid Date Encountered'),
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
    } else {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Failed'),
            content: const Text('Error Encountered'),
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

  deleteCarts(String id) async {
    final String apiUrl =
        'https://api-bali-journey.herokuapp.com/users/payments/carts/$id';
    final prefs = await SharedPreferences.getInstance();
    var getString = prefs.getString('jwt');
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
            title: const Text('Delete Cart Success'),
            content: const Text('Your Cart Item Has been Delete'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text('OK'))
            ],
          );
        },
      );
    } else if (response.statusCode == 404) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Cart Item Failed'),
            content: const Text('Cart Item not Found'),
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
    } else {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Cart Item Failed'),
            content: const Text('Cart Item Error Encountered'),
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

  checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('jwt') == null) {
      print('user null');
    } else {
      setState(() {
        loginChecker = true;
      });
      String data = prefs.getString('jwt') ?? '';
      futureCart = CartApi().getCart();
      print(loginChecker);
    }
    print(prefs.getString('jwt'));
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Visibility(
        visible: loginChecker,
        replacement: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text('Not Logged in')]),
          ),
        ),
        child: futureCart == null
            ? const Center(
                child: Text('Cart is Empty'),
              )
            : FutureBuilder<CartModel>(
                future: futureCart,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var cart = snapshot.data!.cartItems;
                    var total = snapshot.data!.total;
                    return Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          height: 600,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Cart',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Transaction Cart',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff136068)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 400,
                                  child: ListView.builder(
                                    itemCount: cart.length,
                                    itemBuilder: ((context, index) {
                                      var title = cart[index].name;
                                      var image = cart[index].images[0].img;
                                      var date = cart[index].date;
                                      var price = cart[index].price;
                                      var amount = cart[index].amount;
                                      var id = cart[index].id;
                                      var total = amount * int.parse(price);
                                      if (cart.isEmpty) {
                                        return const Center(
                                          child: Text('List is Empty'),
                                        );
                                      } else {
                                        return Stack(
                                          children: [
                                            Column(
                                              children: [
                                                const Divider(),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Colors.black12),
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
                                                                    BorderRadius.circular(
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
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              20,
                                                                          color:
                                                                              Color(0xff136068)),
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
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Color(0xff136068)),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          '$amount pax x ${currencyformatter.format(int.parse(price))}',
                                                                          style: const TextStyle(
                                                                              color: Color(0xff136068),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w100),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          currencyformatter
                                                                              .format(total),
                                                                          style: const TextStyle(
                                                                              color: Color(0xff136068),
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
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              right: 10,
                                              child: InkWell(
                                                  onTap: () {
                                                    deleteCarts(id.toString());
                                                  },
                                                  child: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red,
                                                  )),
                                            ),
                                          ],
                                        );
                                      }
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ]),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            color: const Color(0xffD7F8D7),
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Total',
                                          style: TextStyle(
                                              color: Color(0xff136068),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          currencyformatter
                                              .format(int.parse(total)),
                                          style: const TextStyle(
                                              color: Color(0xff136068),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      var list = [];
                                      for (int i = 0; i < cart.length; i++) {
                                        list.add(cart[i].id);
                                      }
                                      var payload = {'id': list};
                                      updateToPayment(payload);
                                    },
                                    child: const ButtonYellow(title: 'Order'))
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.data == null) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: Text('Cart is Empty'),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
      ),
    ));
  }
}
