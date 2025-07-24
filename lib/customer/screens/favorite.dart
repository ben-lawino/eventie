import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/icons/applogo.png'),
        title: Text('Favorites',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
        //centerTitle: true,
      ),
    );
  }
}
