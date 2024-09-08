import 'package:flutter/material.dart';
import './toggle_theme_button.dart';

class WeatherAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String city;
  final String country;
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<String> onCitySelected;

  const WeatherAppBar({
    super.key,
    required this.city,
    required this.country,
    required this.isDarkMode,
    required this.onDarkModeChanged,
    required this.onCitySelected,
  });

  @override
  _WeatherAppBarState createState() => _WeatherAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _WeatherAppBarState extends State<WeatherAppBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String cityAndCountry = widget.city.isEmpty
        ? "Ingrese una ciudad"
        : "${widget.city}, ${widget.country}";
    return AppBar(
      title: Text(cityAndCountry),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CitySearchDelegate(
                onCitySelected: (city) {
                  widget.onCitySelected(city); // Pasa la ciudad seleccionada
                },
              ),
            );
          },
        ),
        Tooltip(
          message: 'Change brightness mode',
          child: ToggleModeButton(
            isDarkMode: widget.isDarkMode,
            onDarkModeChanged: widget.onDarkModeChanged,
          ),
        ),
      ],
    );
  }
}

class CitySearchDelegate extends SearchDelegate<String> {
  final ValueChanged<String> onCitySelected;

  CitySearchDelegate({required this.onCitySelected});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          close(context, '');
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        query = '';
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListTile(
      title: Text(query),
      onTap: () {
        onCitySelected(query);
        close(context, query);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = ['Lisbon', 'Porto', 'Coimbra', 'Braga', 'Faro'];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
