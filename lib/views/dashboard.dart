
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/DashboardController.dart';
import 'home.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SafeArea(
        child: IndexedStack(
          index: controller.selectedIndex,
          children: [
            Home(),
            const Center(child: Text('Favorite')),
            const Center(child: Text('Setting')),
            const Center(child: Text('Profile')),
          ],
        ),
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: controller.selectedIndex,
        selectedItemColor: const Color(0xFF44b7bf),
        unselectedItemColor: const Color(0xFF898889),
        unselectedLabelStyle: const TextStyle(color: Colors.red),
        onTap: (int index) => controller.selectedMenu = index,
      )),
    );
  }
}
