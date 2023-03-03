import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Text('Profile Page'),
      //     automaticallyImplyLeading: false,
      //     leading: IconButton(
      //       icon: const Icon(Icons.arrow_back),
      //       onPressed: () {
      //         GoRouter.of(context).pop();
      //       },
      //     )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Page'),
            ElevatedButton(
              onPressed: () {
                context.go('/home');
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
