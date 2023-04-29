import 'package:flutter/material.dart';
import 'package:tequevia/home.dart';



class Navigation extends StatefulWidget {
  const Navigation({Key ? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigatioPageName.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,color: Colors.black,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer,color: Colors.black,),
            label: 'offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard,color: Colors.black,),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,color: Colors.black,),
            label: 'cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined,color: Colors.black,),
            label: 'Profile',
          ),

        ],

        currentIndex: _selectedIndex,
        onTap: onItemTaped,
      ),
    );
  }

  int _selectedIndex = 0;
  List navigatioPageName = [
    MyApp (),



  ];
  void onItemTaped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}