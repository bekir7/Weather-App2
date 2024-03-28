import 'package:flutter/material.dart';
import 'package:havadurumu/models/weather_model.dart';
import 'package:havadurumu/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WeatherModel> _weathers = [];

  void _getWeatherData() async {
    _weathers = await WeatherService().getWeatherData();

    setState(() {});
  }

  @override
  void initState() {
    _getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: _weathers.length,
          itemBuilder: (context, index) {
            final WeatherModel weather = _weathers[index];

            double dereceDouble = double.parse(weather.derece);
            int dereceInt = dereceDouble.toInt();
            double dereceDoubleMin = double.parse(weather.min);
            int dereceIntMin = dereceDoubleMin.toInt();
            double dereceDoubleMax = double.parse(weather.max);
            int dereceIntMax = dereceDoubleMax.toInt();
            double dereceDoubleGece = double.parse(weather.gece);
            int dereceIntGece = dereceDoubleGece.toInt();

            return Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${weather.tarih}\n ${weather.gun}\n",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  Column(
                    children: [
                      Image.network(weather.ikon, width: 100),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 25),
                        child: Text(
                          " ${weather.durum.toUpperCase()} ${dereceInt}°",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Min: ${dereceIntMin} °",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Max: ${dereceIntMax} °",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Gece: ${dereceIntGece} °",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Nem: ${weather.nem}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
