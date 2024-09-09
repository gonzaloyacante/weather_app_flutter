import 'package:flutter/material.dart';
import 'theme_toggle_button.dart';

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
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10.0), // Remove padding if any
            child: Icon(Icons.location_on_outlined),
          ),
          Expanded(
            child: Text(
              cityAndCountry,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CitySearchDelegate(
                onCitySelected: (city) {
                  widget.onCitySelected(city);
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
      icon: const Icon(Icons.delete_outlined),
      onPressed: () {
        query = '';
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Usa un callback para asegurarte de que setState() no se llame durante la construcción
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onCitySelected(query); // Llama a la función para actualizar la ciudad
      close(context, query); // Cierra el buscador automáticamente
    });

    return ListTile(
      title: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = [
      'New York',
      'London',
      'Tokyo',
      'Paris',
      'Berlin',
      'Moscow',
      'Los Angeles',
      'Shanghai',
      'Beijing',
      'Hong Kong',
      'Sydney',
      'Madrid',
      'Rome',
      'Toronto',
      'Mexico City',
      'São Paulo',
      'Mumbai',
      'Dubai',
      'Istanbul',
      'Singapore',
      'Seoul',
      'Chicago',
      'Bangkok',
      'Buenos Aires',
      'Cairo',
      'Jakarta',
      'Lagos',
      'Rio de Janeiro',
      'Lima',
      'Caracas',
      'Bogotá',
      'Cape Town',
      'Kuala Lumpur',
      'Delhi',
      'Manila',
      'Melbourne',
      'San Francisco',
      'Washington D.C.',
      'Vienna',
      'Barcelona',
      'Milan',
      'Houston',
      'Miami',
      'Dallas',
      'Amsterdam',
      'Brussels',
      'Warsaw',
      'Stockholm',
      'Zurich',
      'Copenhagen',
      'Athens'
    ];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            // Ejecuta la selección de la ciudad después de la fase de construcción actual
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onCitySelected(suggestion);
              close(context, suggestion); // Cierra el buscador automáticamente
            });
          },
        );
      },
    );
  }
}
