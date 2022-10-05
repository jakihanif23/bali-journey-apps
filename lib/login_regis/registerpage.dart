import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wisata_bali/login_regis/backgound.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final String apiUrl = 'http://10.0.2.2:3000/home';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  registerUser(String name, String email, String password) async {
    var url = Uri.parse('$apiUrl/register');
    var payload = {'name': name, 'email': email, 'password': password};
    var response = await http.post(url, body: payload);
    if (response.statusCode == 201) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Register Successfull'),
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
            title: const Text('Register Failed'),
            content: const Text('Error Encountered when register'),
            actions: [
              TextButton(
                  onPressed: () {
                    _emailController.text = '';
                    _passwordController.text = '';
                    _nameController.text = '';
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const AuthBackground(),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 120),
                      child: Column(
                        children: [
                          Text(
                            'Welcome To',
                            style: GoogleFonts.salsa(
                                fontSize: 36,
                                textStyle:
                                    const TextStyle(color: Color(0xff136068))),
                          ),
                          Text(
                            'Bali Journey Apps',
                            style: GoogleFonts.salsa(
                                fontSize: 36,
                                textStyle:
                                    const TextStyle(color: Color(0xff136068))),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 140),
                      child: Form(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 45,
                              margin: const EdgeInsets.fromLTRB(65, 0, 65, 0),
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xff136068).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: _emailController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: 'Email',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 45,
                              margin: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xff136068).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: _nameController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: 'Name',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 45,
                              margin: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xff136068).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: 'Password',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                registerUser(
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 166,
                                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                decoration: BoxDecoration(
                                    color: const Color(0xff136068)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Register',
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 40),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Already Have an Account? ',
                                    style: const TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: 'Login',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.of(context).pop();
                                            })
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
