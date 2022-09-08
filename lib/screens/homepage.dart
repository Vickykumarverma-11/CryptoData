// ignore_for_file: prefer_const_constructors

import 'package:flutter_assignment_1/models/crypto.dart';
import 'package:flutter_assignment_1/providers/marketpro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Welcome to CryptoUpdate",
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              Text(
                "Crypto Today",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(child: Consumer<MarketProvider>(
                builder: (context, marketProvider, child) {
                  if (marketProvider.isLoading == true) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (marketProvider.markets.length > 0) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
                        child: FittedBox(
                          child: DataTable(
                            showBottomBorder: true,
                            dividerThickness: 2.0,

                            // ignore: prefer_const_literals_to_create_immutables
                            columns: [
                              DataColumn(
                                  label: Text('ID'),
                                  tooltip: 'represents if user is verified.'),
                              DataColumn(
                                  label: Text('Image'),
                                  tooltip: 'represents first name of the user'),
                              DataColumn(
                                  label: Text('Name'),
                                  tooltip: 'represents last name of the user'),
                              DataColumn(
                                  label: Text('Price'),
                                  tooltip:
                                      'represents email address of the user'),
                            ],
                            rows: marketProvider.markets
                                .map((data) =>
                                    // we return a DataRow every time
                                    DataRow(
                                        // List<DataCell> cells is required in every row
                                        cells: [
                                          // I want to display a green color icon when user is verified and red when unverified
                                          DataCell(
                                            Text(
                                              data.id!,
                                              style: TextStyle(
                                                color: Color(0xff0395eb),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage:
                                                  NetworkImage(data.image!),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              data.name.toString(),
                                              style: TextStyle(
                                                color: Color(0xff0395eb),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              "₹ " +
                                                  data.currentPrice.toString(),
                                              style: TextStyle(
                                                color: Color(0xff0395eb),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ]))
                                .toList(),
                          ),
                        ),
                      );
                    } else {
                      return Text('data not found');
                    }
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
