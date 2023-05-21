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
                  'DASHBOARD ',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //add content to drawer
          ListTile(
            title: Text(
              '---- MANAGEMENT FORMS -----',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.medication,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Diagnosis Results',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state

              //close drawer
              onSelectScreenFromDrawer('DiagnosisResults');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.inventory,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Manage Inventory',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state

              //close drawer
              onSelectScreenFromDrawer('InventoryMGMT');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.payment_rounded,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Manage Payments',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state

              //close drawer
              onSelectScreenFromDrawer('PaymentMGMT');
            },
          ),

          const SizedBox(
            height: 30,
          ),
          //add content to drawer
          ListTile(
            title: Text(
              '---------- REPORTS -----------',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),

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

          ListTile(
            leading: const Icon(
              Icons.inventory_outlined,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Inventory Report',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state

              //close drawer
              onSelectScreenFromDrawer('InventoryReport');
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.image_search,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Diagnosis Requests',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state

              //close drawer
              onSelectScreenFromDrawer('User-Uploads');
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
              Icons.payments,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Complete Payments',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state

              //close drawer
              onSelectScreenFromDrawer('PaymentReport');
            },
          ),
          const SizedBox(
            height: 30,
          ),
          //add content to drawer
          ListTile(
            title: Text(
              '---------- ANALYTICS -----------',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.pie_chart_outline_outlined,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Diagnosis Analytics',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state

              //close drawer
              onSelectScreenFromDrawer('DiagnosisAnalytics');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.trending_up,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Data Analytics',
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
