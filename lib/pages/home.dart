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
          // ignoreContainers: true,
          // ignorePointers: true,
          enabled: _isLoading,
          enableSwitchAnimation: true,
          child: ListView.builder(
            itemCount: 6,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            BoneMock.words(4),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const Icon(
                            Icons.ac_unit,
                            size: 64,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(BoneMock.paragraph),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}