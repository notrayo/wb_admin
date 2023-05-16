import 'package:flutter/material.dart';

//import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key, required this.onSelectScreenFromDrawer});

  //logic for switching screens
  final void Function(String identifier) onSelectScreenFromDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Row(
              children: [
                const Icon(
                  Icons.grass_outlined,
                  size: 45,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  'WB DASHBOARD ',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          //add content to drawer

          ListTile(
            leading: const Icon(
              Icons.account_circle,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Users',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state

              //close drawer
              onSelectScreenFromDrawer('Users');
            },
          ),

          //Adding Favourites

          ListTile(
            leading: const Icon(
              Icons.production_quantity_limits_outlined,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Orders',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state
              onSelectScreenFromDrawer('Orders');

              //close drawer
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.trending_up,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Analytics',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state
              onSelectScreenFromDrawer('Analytics');

              //close drawer
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
