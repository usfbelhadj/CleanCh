import 'package:flutter/material.dart';

class AddEvents extends StatelessWidget {
  const AddEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Events'),
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Event Name',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Event Description',
              ),
            ),
            // 3 Check fields for events
          ],
        ));
  }
}

/// Flutter code sample for [DropdownMenu]s. The first dropdown menu has an outlined border.

void main() => runApp(const DropdownMenuExample());

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  eventsLabel? selectedColor;
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<eventsLabel>> colorEntries =
        <DropdownMenuEntry<eventsLabel>>[];
    for (final eventsLabel color in eventsLabel.values) {
      colorEntries.add(
        DropdownMenuEntry<eventsLabel>(
            value: color, label: color.label, enabled: color.label != 'Grey'),
      );
    }

    final List<DropdownMenuEntry<IconLabel>> iconEntries =
        <DropdownMenuEntry<IconLabel>>[];
    for (final IconLabel icon in IconLabel.values) {
      iconEntries
          .add(DropdownMenuEntry<IconLabel>(value: icon, label: icon.label));
    }

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownMenu<eventsLabel>(
                      initialSelection: eventsLabel.Traffic,
                      controller: colorController,
                      label: const Text('Color'),
                      dropdownMenuEntries: colorEntries,
                      onSelected: (eventsLabel? color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                    DropdownMenu<IconLabel>(
                      controller: iconController,
                      enableFilter: true,
                      leadingIcon: const Icon(Icons.search),
                      label: const Text('Icon'),
                      dropdownMenuEntries: iconEntries,
                      inputDecorationTheme: const InputDecorationTheme(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      onSelected: (IconLabel? icon) {
                        setState(() {
                          selectedIcon = icon;
                        });
                      },
                    )
                  ],
                ),
              ),
              if (selectedColor != null && selectedIcon != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        selectedIcon?.icon,
                      ),
                    )
                  ],
                )
              else
                const Text('Please select a color and an icon.')
            ],
          ),
        ),
      ),
    );
  }
}

enum eventsLabel {
  Traffic(
    'Traffic',
  ),
  DangerZone(
    'DangerZone',
  ),
  MoreEvent(
    'MoreEvent',
  );

  const eventsLabel(
    this.label,
  );

  final String label;
}

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}
