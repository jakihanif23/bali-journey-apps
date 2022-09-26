import 'package:flutter/material.dart';

class SearchCardList{
  @required String title;
  @required String image;
  @required String type;
  @required String location;
  @required double rating;

  SearchCardList(this.title, this.image, this.type, this.location, this.rating);
}