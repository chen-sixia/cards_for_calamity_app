// A function that converts a response body into a List<Photo>.
import 'dart:convert';

import 'package:flutter/services.dart';

import 'data/card.dart';

Future<List<String>> parseCards() async {
  final String response =
      await rootBundle.loadString('assets/white_cards.json');
  final parsed = json.decode(response);
  print('parsed.toString()');
  print(parsed.toString());
  // print(parsed.map<String>((json) => String.fromJson(json)).toList());
  return parsed;
}
