import 'package:travel_app/src/models/trips_model.dart';

class AppData {
  static List<String> get categories {
    return [
      'Restaurants', 'Camp',   'Parks', 'Mountain', 'Beach',  'Resort', 'Hotel', 'Cafe',
    ];
  }

  static List<String> get ratingUsers {
    return [
      'https://images.unsplash.com/photo-1496203695688-3b8985780d6a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8UGVvcGxlfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8UGVvcGxlfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1506277886164-e25aa3f4ef7f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8UGVvcGxlfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fFBlb3BsZXxlbnwwfHwwfHx8MA%3D%3D'
    ];
  }

  static List<TripsModel> get getTrips {
    return [
      TripsModel(
        tripID: "T001",
        locationTitle: "Paris, France",
        priceInUSD: "1200",
        dateTime: "13 June 2024 - 18 June 2024",
      ),
      TripsModel(
        tripID: "T002",
        locationTitle: "Kyoto, Japan",
        priceInUSD: "1500",
        dateTime: "5 July 2024 - 10 July 2024",
      ),
      TripsModel(
        tripID: "T003",
        locationTitle: "Cape Town, South Africa",
        priceInUSD: "1800",
        dateTime: "15 July 2024 - 2024",
      ),
      TripsModel(
        tripID: "T004",
        locationTitle: "New York City, USA",
        priceInUSD: "1000",
        dateTime: "5 Aug 2024 - 10 Aug",
      ),
      TripsModel(
        tripID: "T005",
        locationTitle: "Sydney, Australia",
        priceInUSD: "2000",
        dateTime: "27 Dec 2024 - 1 Jan 2025",
      ),
    ];
  }
}
