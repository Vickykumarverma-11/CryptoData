import 'dart:async';

import 'package:flutter_assignment_1/models/apicrypto.dart';
import 'package:flutter_assignment_1/models/crypto.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];
  MarketProvider() {
    fetchdata();
  }

  void fetchdata() async {
    List<dynamic> _markets = await Api.getData();
    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();
    Timer(const Duration(seconds: 3), () {
      fetchdata();
    });
  }
}
