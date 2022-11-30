import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: [
            GoogleMap(initialCameraPosition: CameraPosition(
              target: LatLng(10.7915178, 106.7271442),
              zoom: 10,
            )),
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: Text(
                    "Taxi App",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),),

                  leading: IconButton(onPressed: () { 
                    
                  },
                    icon: Image.asset("assets/ic/ic_menu.png"),),
                  actions: [Image.asset("assets/ic/ic_notify.png")],

                ),
                Padding(
                  padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                  // child: RidePicker(),
                )
              ],
            )),
          ],

        ),

      ),
      drawer: Drawer(

      ),
    );
  }
}
