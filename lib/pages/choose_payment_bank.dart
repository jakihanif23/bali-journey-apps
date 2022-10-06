import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/pages/get_detail_payment.dart';
import 'package:wisata_bali/widgets/payment_bank_widget.dart';
import 'package:http/http.dart' as http;

class ChoosePaymentBank extends StatefulWidget {
  final String id;
  const ChoosePaymentBank({super.key, required this.id});

  @override
  State<ChoosePaymentBank> createState() => _ChoosePaymentBankState();
}

class _ChoosePaymentBankState extends State<ChoosePaymentBank> {
  var payload = [
    {'image': 'assets/bnni.png', 'bank': 'bni'},
    {'image': 'assets/bri.png', 'bank': 'bri'},
    {'image': 'assets/bca.png', 'bank': 'bca'}
  ];
  paymentPay(String bank) async {
    final String apiUrl =
        'https://api-bali-journey.herokuapp.com/users/payments/pay/${widget.id}';
    var prefs = await SharedPreferences.getInstance();
    var getString = prefs.getString('jwt');
    var response = await http.post(Uri.parse(apiUrl),
        headers: {'access_token': getString.toString()},
        body: {'payment_type': 'bank_transfer', 'bank': bank});
    if (response.statusCode == 200) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Updated'),
            content: const Text('Payment Has Been Updated'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (builder) =>
                            GetDetailPaymentPage(id: widget.id)));
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
            content: const Text('Payment Data Has Been Failed'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Bank Transfer',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                child: Column(
                  children: List.generate(payload.length, (index) {
                    var image = payload[index]['image'];
                    var bank = payload[index]['bank'];
                    return InkWell(
                      onTap: () {
                        paymentPay(bank.toString());
                      },
                      child: PaymentBankWidget(
                          image: image.toString(),
                          title: bank.toString().toUpperCase()),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
