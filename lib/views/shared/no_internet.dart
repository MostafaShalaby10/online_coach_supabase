import 'package:flutter/material.dart';
import 'package:online_coach_supabase/shared/components/components.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off , color: Colors.red,size: 40,) ,
            text( textAlign: TextAlign.center,text: "No internet Connection" , fontSize: 25),
          ],
        ),
      ),
    );
  }
}
