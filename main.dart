import 'package:flutter/material.dart';

void main() {
  runApp(TourApp());
}

class TourApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tour Booking App',
      home: HomeScreen(),
    );
  }
}

class Tour {
  final String name;
  final String location;
  final String price;

  Tour({required this.name, required this.location, required this.price});
}

List<Tour> tours = [
  Tour(name: "Goa Beach", location: "Goa", price: "₹5000"),
  Tour(name: "Coorg Hills", location: "Karnataka", price: "₹3000"),
  Tour(name: "Manali Snow", location: "Himachal", price: "₹7000"),
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tour Packages")),
      body: ListView.builder(
        itemCount: tours.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(tours[index].name),
              subtitle: Text(tours[index].location),
              trailing: Text(tours[index].price),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(tour: tours[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Tour tour;

  DetailScreen({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tour.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Location: ${tour.location}", style: TextStyle(fontSize: 18)),
            Text("Price: ${tour.price}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Book Now"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingScreen(tour: tour),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class BookingScreen extends StatefulWidget {
  final Tour tour;

  BookingScreen({required this.tour});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController();

  void bookTour() {
    String name = nameController.text;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Booking Confirmed"),
        content: Text("Thank you $name!\nTour booked: ${widget.tour.name}"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Tour")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Enter your name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: bookTour,
              child: Text("Confirm Booking"),
            )
          ],
        ),
      ),
    );
  }
}
