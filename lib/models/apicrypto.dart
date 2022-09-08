import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static Future<List<dynamic>> getData() async {
    Uri request = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=INR&order=market_cap_desc&per_page=30&page=1&sparkline=false");
    var response = await http.get(request);
    var decoderequest = jsonDecode(response.body);

    List<dynamic> markets = decoderequest as List<dynamic>;
    return markets;
  }
}
