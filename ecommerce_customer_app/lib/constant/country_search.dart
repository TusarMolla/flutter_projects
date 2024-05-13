import 'package:flutter/material.dart';
import 'package:grostore/constant/country_code.dart';

class CountrySearchDialog extends StatefulWidget {
  @override
  _CountrySearchDialogState createState() => _CountrySearchDialogState();
}

class _CountrySearchDialogState extends State<CountrySearchDialog> {
  List<Country> country =  CountryCode().get();

  List<Country> filteredCountry = [];

  @override
  void initState() {
    filteredCountry = country;
    super.initState();
  }

  void filtercountry(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredCountry = country
          .where((product) => product.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Search Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            onChanged: filtercountry,
            decoration: InputDecoration(
              labelText: 'Search',
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountry.length,
              itemBuilder: (context, index) {
                final country = filteredCountry[index];
                return ListTile(
                  title: Text(country.name),
                  onTap: () {
                    Navigator.of(context).pop(country);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
