import 'dart:convert';

import 'package:http/http.dart';

const String apiKey =
    "9fa33eba1af3456ca141ca369da6c693eec42cd14dcc7bd8e6bdd44368dfd7dddd61";

const String apiBaseUrl = "https://min-api.cryptocompare.com/data/pricemulti";

// https://min-api.cryptocompare.com/data/pricemulti?fsyms=ETH&tsyms=BTC&api_key=9fa33eba1af3456ca141ca369da6c693eec42cd14dcc7bd8e6bdd44368dfd761

class CoinBrain {
  Future<Map<String, double?>> getCoinData(String currency2) async {
    final Map<String, double?> exchangesRates = <String, double?>{};

    for (String crypto in cryptoList) {
      final Response response = await get(
        Uri.parse(
          '$apiBaseUrl?fsyms=$crypto&tsyms=$currency2&api_key=$apiKey',
        ),
      );
      if (response.statusCode == 200) {
        final String data = response.body;
        final double rate = jsonDecode(data)[crypto][currency2];
        exchangesRates[crypto] = rate;
      } else {
        print(response.statusCode);
        exchangesRates[crypto] = null;
      }
    }
    return exchangesRates;
  }
}

const List<String> currenciesList = <String>[
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = <String>[
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {}
