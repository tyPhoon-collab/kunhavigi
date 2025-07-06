import 'package:flutter/material.dart';
import 'package:kunhavigi_flutter/browse/presentation/entries_list_view.dart';

class KunhavigiPage extends StatelessWidget {
  const KunhavigiPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: EntriesListView(),
      ),
    );
  }
}
