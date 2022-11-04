import 'package:flutter/material.dart';
import 'package:flutter_test_imagegallery/carousel.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

enum _SelectedTab { home, favorite, search, person }

class GalleryScreen extends StatefulWidget {
  GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  List<String> images = [
    'https://www.techciti.com.au/media/catalog/product/cache/d4fb4db5e3c0571a4cd8f9a0939fde5f/a/p/apple-iphone-12-pro-combo-side_1.jpg',
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://i.guim.co.uk/img/media/fe1e34da640c5c56ed16f76ce6f994fa9343d09d/0_174_3408_2046/master/3408.jpg?width=620&quality=45&dpr=2&s=none',
    'https://i.ibb.co/N1Tb3qS/Product-Detail-Image.png'
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        extendBody: true,
        // bottomNavigationBar: BottomNavigationBar(
        //     showSelectedLabels: false,
        //     showUnselectedLabels: false,
        //     type: BottomNavigationBarType.fixed,
        //     backgroundColor: Color(0xFF25584F),
        //     items: [
        //       BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.category), label: "Store"),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.notifications), label: "Noti"),
        //       BottomNavigationBarItem(icon: Icon(Icons.person), label: "User")
        //     ]),
        bottomNavigationBar: DotNavigationBar(
          splashColor: Colors.transparent,
          enablePaddingAnimation: false,
          enableFloatingNavBar: false,
          marginR: EdgeInsets.zero,
          borderRadius: 0,
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          onTap: _handleIndexChanged,
          dotIndicatorColor: Colors.green,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xFF25584F),
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.home),
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Image.network(
                'https://i.ibb.co/N1Tb3qS/Product-Detail-Image.png',
                width: 25,
              ),
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.search),
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Icon(Icons.person),
            ),
          ],
        ),

        appBar: AppBar(
          title: const Text('Title'),
          elevation: 0,
        ),
        body: Scaffold(
          key: _scaffoldKey,
          endDrawer: const Drawer(),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xFFD9D9D9)))),
                child: TabBar(
                  splashFactory: NoSplash.splashFactory,
                  isScrollable: true,
                  indicatorColor: Colors.green,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 5,
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.normal),
                  tabs: [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'Apple',
                    ),
                    Tab(
                      text: 'Samsung',
                    ),
                    Tab(
                      text: 'Huawei',
                    ),
                    Tab(
                      text: 'Vivo',
                    ),
                    Tab(
                      text: 'Oppo',
                    ),
                    Tab(
                      text: 'Other',
                    ),
                  ],
                ),
              ),
              Carousel(
                images: images,
              ),
              //   ElevatedButton(
              //       onPressed: () {
              //         _scaffoldKey.currentState!.openEndDrawer();
              //       },
              //       child: const Text('Open Drawer')),
            ],
          ),
        ),
      ),
    );
  }
}
