import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/models/city.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<City> cities =
        City.citiesList.where((city) => city.isDefault == false).toList();

    List<City> selectedCities = City.getSelectedCities();

    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myConstants.secondaryColor,
        title:
            Center(child: Text(selectedCities.length.toString() + ' Selected')),
      ),
      body: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: size.height * 0.08,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: cities[index].isSelected == true
                    ? Border.all(
                        color: myConstants.secondaryColor.withOpacity(0.6),
                        width: 2)
                    : Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: myConstants.primaryColor.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cities[index].isSelected = !cities[index].isSelected;
                      });
                    },
                    child: Image.asset(
                      cities[index].isSelected == true
                          ? 'assets/checked.png'
                          : 'assets/unchecked.png',
                      width: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    cities[index].city,
                    style: TextStyle(
                        fontSize: 16,
                        color: cities[index].isSelected == true
                            ? myConstants.primaryColor
                            : Colors.black38),
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(selectedCities.length);
        },
        child: Icon(Icons.pin_drop),
        backgroundColor: myConstants.secondaryColor,
      ),
    );
  }
}
