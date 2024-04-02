import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:havadurumu/models/weather_model.dart';
import 'package:havadurumu/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<WeatherModel> _weathers;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getWeatherData();
  }

  Future<void> _getWeatherData() async {
    try {
      final List<WeatherModel> weathers =
          await WeatherService().getWeatherData();
      setState(() {
        _weathers = weathers;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/cizim5.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    CarouselSlider.builder(
                      itemCount: _weathers.length,
                      itemBuilder: (context, index, realIndex) {
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
                          padding: const EdgeInsets.all(10),
                          margin:
                              const EdgeInsets.symmetric(horizontal: 10),
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              Image.network(weather.ikon, width: 80),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  " ${weather.durum.toUpperCase()} ${dereceInt}°",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Min: ${dereceIntMin} °",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        "Max: ${dereceIntMax} °",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Gece: ${dereceIntGece} °",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        "Nem: ${weather.nem}%",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        aspectRatio: 5 / 3,
                        enableInfiniteScroll: false,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
