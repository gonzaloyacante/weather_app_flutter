import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WeatherAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String cityName;
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const WeatherAppBar({
    super.key,
    required this.cityName,
    required this.isDarkMode,
    required this.onDarkModeChanged,
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
    return AppBar(
      title: Text(widget.cityName),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CitySearchDelegate(
                onCitySelected: (city) {
                  _searchController.text = city;
                },
              ),
            );
          },
        ),
        Tooltip(
          message: 'Change brightness mode',
          child: IconButton(
            isSelected: widget.isDarkMode,
            onPressed: () {
              widget.onDarkModeChanged(!widget.isDarkMode);
            },
            icon: const Icon(Icons.wb_sunny_outlined),
            selectedIcon: const Icon(Icons.brightness_2_outlined),
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
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.volume_up),
      onPressed: () {
        close(context, '');
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
