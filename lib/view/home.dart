import 'package:flutter/material.dart';
import 'package:ugd_layout/view/view_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  List<bool> _isBoxExpandedList = List.generate(7, (index) => false);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _expandBox(int index) {
    setState(() {
       _isBoxExpandedList[index] = !_isBoxExpandedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _selectedIndex == 0 ? buildGridWrap() : _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildGridWrap() {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: List.generate(7, (index) => buildGridItem(index)),
          ),
        ),
      ),
    );
  }
   Widget buildGridItem(int index) {
    return InkWell(
      onTap: () => _expandBox(index), // Menggunakan fungsi _expandBox dengan indeks kotak
      
            child: AnimatedContainer(
              margin: EdgeInsets.all(2.0),
              width: _isBoxExpandedList[index] ? 400 : 180,
              height: _isBoxExpandedList[index] ? 400 : 180,
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.blue,
              ),
        ),
      );
    }


  static const List<Widget> _widgetOptions = <Widget>[
    ListNamaView(),
    ListNamaView(),
    Center(
      child: Text(
        'Index 2: Profile',
      ),
    ),
  ];
}
