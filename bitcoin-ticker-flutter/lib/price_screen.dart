import 'dart:async';
import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Timer? _debounce;
  Map<String, double?> rates = <String, double?>{};

  DropdownButton<String> getDropdownButton() {
    final List<DropdownMenuItem<String>> dropdownItems =
        <DropdownMenuItem<String>>[];
    for (String currency in currenciesList) {
      final DropdownMenuItem<String> newItem =
          DropdownMenuItem<String>(value: currency, child: Text(currency));
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (String? value) {
        if (value != null) {
          setState(() {
            selectedCurrency = value;
          });
        }
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    final List<Text> pickerItems = <Text>[];
    for (String currency in currenciesList) {
      final Text newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (int selectedIndex) {
        print(selectedIndex);
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 500), () {
            // do something with query
            getRate().then((Map<String, double?> value) {
              setState(() {
                rates = value;
              });
            });
          });
        });
      },
      children: pickerItems,
    );

    // throttle ou debounce
  }

  List<Widget> getRateCards() {
    final List<RateCard> rateCardItems = <RateCard>[];
    for (String crypto in cryptoList) {
      final RateCard newItem = RateCard(
        rate: rates[crypto],
        selectedCurrency: selectedCurrency,
        selectedCrypto: crypto,
      );
      rateCardItems.add(newItem);
    }
    return rateCardItems;
  }

  Future<Map<String, double?>> getRate() async {
    final CoinBrain coinBrain = CoinBrain();
    // print(rate);
    return coinBrain.getCoinData(selectedCurrency);
  }

  @override
  void initState() {
    super.initState();
    getRate().then((Map<String, double?> value) {
      setState(() {
        rates = value;
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ...getRateCards(),
          // ElevatedButton(
          //   onPressed: () async {
          //     final Map<String, double?> newValue = await getRate();
          //     setState(() {
          //       rates = newValue;
          //     });
          //   },
          //   child: const Text("refresh"),
          // ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}

class RateCard extends StatelessWidget {
  const RateCard({
    Key? key,
    required this.rate,
    required this.selectedCurrency,
    required this.selectedCrypto,
  }) : super(key: key);

  final double? rate;
  final String selectedCurrency;
  final String selectedCrypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 28.0,
          ),
          child: Text(
            '1 $selectedCrypto = ${rate ?? '? '} $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
