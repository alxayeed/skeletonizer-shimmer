import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skeletonizer Demo')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Skeletonizer(
          enabled: _isLoading,
          enableSwitchAnimation: true,
          child: ListView.builder(
            itemCount: 6,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          "This would be a nice headline for this card",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ListTile(
                      title: Text('Item ${index+1} title'),
                      subtitle: const Text('Subtitle here'),
                      trailing: const Icon(
                        Icons.ac_unit,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}