import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parcial3/widgets.dart';

int _selectedIndex = 0;
final placesCardListProvider =
    StateNotifierProvider<PlacesCardListNotifier, List<PlacesCard>>((ref) {
  return PlacesCardListNotifier([
    const PlacesCard(
        image: "image1.jpeg",
        title: "title",
        description: "description",
        visited: false),
    const PlacesCard(
        image: "image2.jpeg",
        title: "title2",
        description: "description2",
        visited: false),
    const PlacesCard(
        image: "image3.jpeg",
        title: "title3",
        description: "description3",
        visited: false),
  ]);
});

class PlacesCardListNotifier extends StateNotifier<List<PlacesCard>> {
  PlacesCardListNotifier(List<PlacesCard> initialPlaces) : super([]);

  void toggleVisited(int index) {
    if (index >= 0 && index < state.length) {
      final newList = List<PlacesCard>.from(state);
      newList[index] = PlacesCard(
        image: state[index].image,
        title: state[index].title,
        description: state[index].description,
        visited: !state[index].visited,
      );
      state = newList;
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {}

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [PlacesPage(), VisitsPage()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTapped,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Lugares',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pin_drop),
              label: 'Visitados',
            ),
          ]),
    );
  }
}

class PlacesPage extends ConsumerWidget {
  const PlacesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesCardListProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              Text('Guatemala', style: Theme.of(context).textTheme.titleLarge),
              Text('Corazón del mundo maya',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Center(
                child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(places.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(placesCardListProvider.notifier)
                              .toggleVisited(index);
                        },
                        child: places[index],
                      );
                    })),
              )),
        ),
      ],
    );
  }
}

class VisitsPage extends ConsumerWidget {
  const VisitsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesCardListProvider);
    final visitedPlaces = places.where((place) => place.visited).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text('Lugares visitados',
              style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Center(
                child: ListView.builder(
                  itemCount: visitedPlaces.length,
                  itemBuilder: (context, index) {
                    return visitedPlaces[index];
                  },
                ),
              )),
        ),
      ],
    );
  }
}
