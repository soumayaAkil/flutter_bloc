
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_router.gr.dart';
import '../../business_logic/landing_bloc/landing_bloc.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.grid_3x3),
    label: 'Category',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search_outlined),
    label: 'Search',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite_outline),
    label: 'Favourite',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_bag_outlined),
    label: 'Cart',
  ),
];

int currentIndex = 0;


 List<Widget> bottomNavScreen = <Widget>[




  Text('Index 3: Favourite'),
  Text('Index 4: Cart'),
];

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingBloc, LandingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body:  bottomNavScreen.elementAt(state.tabIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              BlocProvider.of<LandingBloc>(context)
                  .add(TabChange(tabIndex: index));
            },
          ),
        );
      },
    );
  }
}