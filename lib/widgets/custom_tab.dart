import 'package:flutter/material.dart';

class StapledBrochuresContent extends StatelessWidget {
  const StapledBrochuresContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(title: Text("A6 Stapled Brochures")),
        ListTile(title: Text("A5 Stapled Brochures")),
        ListTile(title: Text("A4 Stapled Brochures")),
        ListTile(title: Text("DL Stapled Brochures")),
        ListTile(title: Text("Square Stapled Brochures")),
        ListTile(title: Text("Eco-Friendly Stapled Brochures")),
      ],
    );
  }
}

class PerfectBoundContent extends StatelessWidget {
  const PerfectBoundContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(title: Text("A6 Perfect Bound Brochures")),
        ListTile(title: Text("A5 Perfect Bound Brochures")),
        ListTile(title: Text("A4 Perfect Bound Brochures")),
        ListTile(title: Text("DL Perfect Bound Brochures")),
        ListTile(title: Text("Royal Perfect Bound Brochures")),
      ],
    );
  }
}

class WiroBoundContent extends StatelessWidget {
  const WiroBoundContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(title: Text("A6 Wiro Bound Brochures")),
        ListTile(title: Text("A5 Wiro Bound Brochures")),
        ListTile(title: Text("A4 Wiro Bound Brochures")),
        ListTile(title: Text("DL Wiro Bound Brochures")),
      ],
    );
  }
}

class FoldedBrochuresContent extends StatelessWidget {
  const FoldedBrochuresContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(title: Text("Half Fold")),
        ListTile(title: Text("Tri Fold")),
        ListTile(title: Text("Gate Fold")),
        ListTile(title: Text("Cross Fold")),
        ListTile(title: Text("Map Fold")),
      ],
    );
  }
}
