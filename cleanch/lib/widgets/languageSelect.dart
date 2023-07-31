import 'package:flutter/material.dart';

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String? selectedLanguage = 'English'; // 0

  void _onLanguageSelected(String? language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  void _applyLanguage() {
    //logic
  }

  Widget _buildLanguageButton(String language) {
    bool isSelected = selectedLanguage == language;

    return RadioListTile<String>(
      title: Text(
        language,
        style: TextStyle(
          fontSize: 16,
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
      value: language,
      groupValue: selectedLanguage,
      onChanged: _onLanguageSelected,
      selected: isSelected,
      activeColor: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Selection'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildLanguageButton('Français'),
                _buildLanguageButton('Italiano'),
                _buildLanguageButton('Deutsch'),
                _buildLanguageButton('English'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _applyLanguage,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Apply Language',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
