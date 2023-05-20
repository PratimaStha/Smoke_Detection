import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/contact_model.dart';

List<ContactModel> contactListData = [
  ContactModel(
    location: "Pokhara",
    number: 9806182359,
  ),
  ContactModel(
    location: "Butwal",
    number: 9806636023,
  ),
  ContactModel(
    location: "Bhairahawa",
    number: 9824133551,
  ),
  ContactModel(
    location: "Kathmandu",
    number: 9807786498,
  ),
  ContactModel(
    location: "Bhaktapur",
    number: 9807786498,
  ),
  ContactModel(
    location: "Janakpur",
    number: 9807786498,
  ),
  ContactModel(
    location: "Lalitpur",
    number: 9807786498,
  ),
  ContactModel(
    location: "Syangja",
    number: 9807786498,
  ),
  ContactModel(
    location: "Palpa",
    number: 9807786498,
  ),
  ContactModel(
    location: "Baglung",
    number: 9807786498,
  ),
  ContactModel(
    location: "Pokhara, NewRoad",
    number: 9807786498,
  ),
  ContactModel(
    location: "Kathmandu, Anamnagar",
    number: 9807786498,
  ),
  ContactModel(
    location: "Dang",
    number: 9807786498,
  ),
  ContactModel(
    location: "Jhapa",
    number: 9807786498,
  ),
  ContactModel(
    location: "Nepalgunj",
    number: 9807786498,
  ),
  ContactModel(
    location: "Bhairahawa",
    number: 9807786498,
  ),
  ContactModel(
    location: "Illam",
    number: 9807786498,
  ),
  ContactModel(
    location: "Simari",
    number: 9807786498,
  ),
  ContactModel(
    location: "Sunsari",
    number: 9807786498,
  ),
  ContactModel(
    location: "Birtamod",
    number: 986698955,
  ),
];

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<ContactModel> display_list = List.from(contactListData);
  void updateList(String value) {
    setState(() {
      display_list = contactListData
          .where((element) =>
              element.location?.toLowerCase().contains(value.toLowerCase()) ??
              false)
          .toList();
    });
    log(display_list.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (value) => updateList(value),
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              labelText: 'Search by location...',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Fire Brigade Contact No',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          DataTable(
            columnSpacing: 30,
            border: TableBorder.all(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade400,
            ),
            columns: const [
              DataColumn(
                label: Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Phone No',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            rows: List.generate(
              display_list.length,
              (index) {
                return DataRow(
                  cells: [
                    DataCell(
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Text(
                          display_list[index].location ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        child: Row(
                          children: [
                            // width: MediaQuery.of(context).size.width * 0.35,
                            // child:
                            Text(
                              display_list[index].number.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final Uri url = Uri(
                                    scheme: 'tel',
                                    path: ("${display_list[index].number}"));
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  print("cannot launch");
                                }
                              },
                              child: Text("Call"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF075E54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
