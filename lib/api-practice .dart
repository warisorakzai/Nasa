import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  const Api({super.key});

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  Map<String, dynamic>? data;
  bool isLoading = true;
  Future<void> fetchapi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        bool isLoading = false;
      });
    } else {
      setState(() {
        bool isLoading = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(data!['title']), Text(data!['body'])],
      ),
    );
  }
}
