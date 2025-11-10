import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa/widgets/build_card.dart';
import 'package:nasa/widgets/info_row.dart';
import 'package:nasa/widgets/section_title.dart';

class Nasa extends StatefulWidget {
  const Nasa({super.key});

  @override
  State<Nasa> createState() => _NasaState();
}

class _NasaState extends State<Nasa> {
  Map<String, dynamic>? data;
  bool isLoading = true;

  Future<void> fetchApi() async {
    final response = await http.get(
      Uri.parse(
        'https://api.nasa.gov/insight_weather/?api_key=hZbOwxTaL23lRlTajLui1mR59orYqtEXqID9gnOP&feedtype=json&ver=1.0',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade700,
        title: const Text('NASA Mars Weather'),
        centerTitle: true,
        elevation: 4,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.deepPurpleAccent),
            )
          : data == null
          ? const Center(
              child: Text(
                'Failed to load data 😢',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: data!['sol_keys'].length,
              itemBuilder: (context, index) {
                String sol = data!['sol_keys'][index];
                var solData = data![sol];
                return buildWeatherCard(sol, solData);
              },
            ),
    );
  }
}
