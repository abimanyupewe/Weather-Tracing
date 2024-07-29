import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  Future<Map<String, dynamic>> getDataFromAPI() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=-7.9771206&lon=112.6340291&appid=514cd0d83cd36c5c6c0ac5388101ea2f'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tracing'),
        ),
        body: Container(
          child: FutureBuilder(
            future: getDataFromAPI(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData) {
                final data = snapshot.data!; // non nullables

                final iconCode = data['weather'][0]['icon'];

                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://openweathermap.org/img/wn/${iconCode}@2x.png'),
                                  fit: BoxFit
                                      .cover, // Menyesuaikan gambar agar sesuai dengan ukuran container
                                ),
                              ),
                            ),
                          ),
                          Text(data['weather'][0]['main']),
                          Text("Suhu ${data['main']['feels_like']}")
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Text('Tempat tidak diketahui');
              }
            },
          ),
        ),
      ),
    );
  }
}
