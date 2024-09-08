// import 'package:flutter/material.dart';

// class SettingsScreen extends StatefulWidget {
//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   bool isDarkMode = false;
//   String temperatureUnit = 'C';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Settings')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             SwitchListTile(
//               title: const Text('Dark Mode'),
//               value: isDarkMode,
//               onChanged: (value) {
//                 setState(() {
//                   isDarkMode = value;
//                 });
//               },
//             ),
//             ListTile(
//               title: const Text('Temperature Unit'),
//               trailing: DropdownButton<String>(
//                 value: temperatureUnit,
//                 items: ['C', 'F'].map((unit) {
//                   return DropdownMenuItem(
//                     value: unit,
//                     child: Text('°$unit'),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     temperatureUnit = value!;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
