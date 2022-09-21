import 'package:flutter/material.dart';

class DestinationReviewCard extends StatelessWidget {
  const DestinationReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 377,
      height: 191,
      decoration: BoxDecoration(
          color: Color(0xffD9F9F8),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Container(
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                          AssetImage('assets/man.jpg'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              0, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mamang Kesbor',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                'New Delhi',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    child: Text('Bintang di surga'),
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                          alignment: Alignment.topRight,
                          child: Text(
                            '20 Desember 2021',
                            style: TextStyle(
                                fontSize: 8,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque cursus ex sed egestas sagittis. Nunc suscipit ultrices lorem id viverra. Nam hendrerit nunc eu vulputate pulvinar. Ut dapibus erat vulputate, viverra nunc sed, tempor nisl. Donec eget mi arcu. Sed vitae euismod velit. Aliquam aliquam ex at risus sagittis, vitae ultricies nulla dapibus. Curabitur cursus velit quis ipsum elementum, vitae gravida ipsum pretium. Vivamus nibh massa, auctor quis quam eu, viverra fermentum nisl. Fusce nec pretium mi, ac porta nunc. Integer lacus turpis, interdum eu semper id, iaculis ut odio. Nullam bibendum pharetra tempus. Proin eu libero nec nisl ultricies fringilla vel id sapien. Suspendisse ultricies sagittis orci euismod pulvinar.',
                  style: TextStyle(
                      fontSize: 12
                  ),
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
