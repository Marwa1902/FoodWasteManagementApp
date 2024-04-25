import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const homePage(),
    const searchPage(),
    const profilePage(),
  ];

  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();

  String? _avatarUrl;
  var _loading = true;

  Future<void> get _getProfile async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      _usernameController.text = (data['username'] ?? '') as String;
      _websiteController.text = (data['website'] ?? '') as String;
      _avatarUrl = (data['avatar_url'] ?? '') as String;
    } on PostgrestException catch (error) {
      SnackBar(
        content: Text(error.message),
        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 252, 255),
      //APPBAR
      appBar: AppBar(
        title: const Text(
          'Hello User!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'Piazolla',
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 252, 255),
        toolbarHeight: 100.0,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),

      //BOTTOM NAV BAR
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          unselectedIconTheme: const IconThemeData(color: Colors.white),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.black,
            ),
          ],
          currentIndex: _selectedIndex,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }

  @override
  void debugFillProperties(properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_avatarUrl', _avatarUrl));
    properties.add(DiagnosticsProperty<bool>('_loading', _loading));
    properties
        .add(DiagnosticsProperty<Future<void>>('_getProfile', _getProfile));
  }
}

// ignore: camel_case_types
class profilePage extends StatelessWidget {
  const profilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));
  }
}

// ignore: camel_case_types
class searchPage extends StatefulWidget {
  const searchPage({
    super.key,
  });

  @override
  State<searchPage> createState() => _searchPageState();
}

// ignore: camel_case_types
class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return const Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));
  }
}

// ignore: camel_case_types
class homePage extends StatelessWidget {
  const homePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontFamily: 'Piazolla',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 250,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'view all',
                    style: TextStyle(
                      fontFamily: 'Piazolla',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 160,
                height: 50,
                color: Colors.red,
              ),
              Container(
                width: 160,
                height: 50,
                color: Colors.blue,
              ),
              Container(
                width: 160,
                height: 50,
                color: Colors.green,
              ),
              Container(
                width: 160,
                height: 50,
                color: Colors.yellow,
              ),
              Container(
                width: 160,
                height: 50,
                color: Colors.orange,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Events',
                style: TextStyle(
                  fontFamily: 'Piazolla',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 280,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'view all',
                    style: TextStyle(
                      fontFamily: 'Piazolla',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  CardExample(
                    text: 'Food Festivals',
                    rotation: -90,
                  ),
                  CardExample(
                    text: 'Charity Events',
                    rotation: -90,
                  ),
                  CardExample(
                    text: 'Tasting Events',
                    rotation: -90,
                  ),
                ],
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Tips',
                style: TextStyle(
                  fontFamily: 'Piazolla',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 298,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'view all',
                    style: TextStyle(
                      fontFamily: 'Piazolla',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  CardExample(
                    text:
                        'Use durable bags or bins specifically designed for food waste disposal',
                    rotation: 0,
                  ),
                  CardExample(
                    text:
                        'Use durable bags or bins specifically designed for food waste disposal',
                    rotation: 0,
                  ),
                  CardExample(
                    text:
                        'Use durable bags or bins specifically designed for food waste disposal',
                    rotation: 0,
                  ),
                ],
              )),
        )
      ],
    ));
  }
}

// ignore: must_be_immutable
class CardExample extends StatefulWidget {
  String text;
  int rotation;

  CardExample({super.key, required this.text, required this.rotation});

  @override
  State<CardExample> createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {
  late String cardText;
  late int i;

  @override
  void initState() {
    super.initState();
    cardText = widget.text;
    i = widget.rotation;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: const Color.fromARGB(255, 208, 240, 255),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            width: 300,
            height: 200,
            child: Align(
              alignment: const Alignment(1.2, 0),
              child: Transform.rotate(
                angle: i * 3.1415926535 / 180, // Convert degrees to radians
                child: Text(
                  cardText,
                  style: const TextStyle(
                      fontFamily: 'Piazolla',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
