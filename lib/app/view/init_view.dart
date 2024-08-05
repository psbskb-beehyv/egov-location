import 'package:egov/app/init/app_init.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';

class InitView extends StatelessWidget {
  const InitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
          future: AppInit.init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const HomeView();
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
