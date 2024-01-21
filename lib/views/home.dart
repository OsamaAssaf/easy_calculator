import 'package:easy_calculator/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    List<String> calculateValue = Provider.of<HomeViewModel>(context).calculateValue;
    String result = Provider.of<HomeViewModel>(context).result;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Calculator'),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: width,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  width: width,
                )),
                Expanded(
                  child: Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      calculateValue.join(),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      result,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  color: Colors.grey[900],
                  width: width * 0.75,
                  child: GridView.count(
                    crossAxisCount: 3,
                    reverse: true,
                    children: homeViewModel.numberList
                        .map(
                          (value) => Provider.of<HomeViewModel>(context).pressControl(value, true),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  color: Colors.grey[800],
                  width: width * 0.20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: homeViewModel.operatorsList
                        .map(
                          (value) => Column(
                            children: [
                              Provider.of<HomeViewModel>(context).pressControl(value, false),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  color: Colors.greenAccent,
                  width: width * 0.05,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
