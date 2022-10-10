import 'package:flutter/material.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
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
                      ),
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'About App',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'About App Info',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Version 1.0.0.1',
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 116,
                        backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/69/69589.png'),
                      ),
                    ),
                    Text(
                      ' © 2022 Bali Apps Journey',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
