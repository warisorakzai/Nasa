import 'package:flutter/material.dart';
import 'package:nasa/widgets/info_row.dart';
import 'package:nasa/widgets/section_title.dart';

Widget buildWeatherCard(String sol, Map<String, dynamic> solData) {
  // Extract values
  String firstUTC = solData['First_UTC'] ?? 'N/A';
  String season = solData['Season'] ?? 'Unknown';

  double avgTemp = (solData['AT']?['av'] ?? 0).toDouble();
  double minTemp = (solData['AT']?['mn'] ?? 0).toDouble();
  double maxTemp = (solData['AT']?['mx'] ?? 0).toDouble();

  double avgWind = (solData['HWS']?['av'] ?? 0).toDouble();
  double minWind = (solData['HWS']?['mn'] ?? 0).toDouble();
  double maxWind = (solData['HWS']?['mx'] ?? 0).toDouble();

  double avgPressure = (solData['PRE']?['av'] ?? 0).toDouble();
  double minPressure = (solData['PRE']?['mn'] ?? 0).toDouble();
  double maxPressure = (solData['PRE']?['mx'] ?? 0).toDouble();

  double compassDegrees =
      (solData['WD']?['most_common']?['compass_degrees'] ?? 0).toDouble();
  String compassPoint =
      solData['WD']?['most_common']?['compass_point'] ?? 'N/A';

  return Container(
    margin: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade800, Colors.black87],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurpleAccent.withOpacity(0.4),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.public, size: 70, color: Colors.white70),
        const SizedBox(height: 10),

        Text(
          "🪐 Mars Sol: $sol",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text("Season: $season", style: const TextStyle(color: Colors.white70)),
        Text(
          "First UTC: $firstUTC",
          style: const TextStyle(color: Colors.white70),
        ),
        const Divider(color: Colors.white38, height: 25, thickness: 1),

        sectionTitle("🌡️ Temperature (°C)"),
        infoRow("Average", "$avgTemp"),
        infoRow("Minimum", "$minTemp"),
        infoRow("Maximum", "$maxTemp"),

        const SizedBox(height: 10),

        sectionTitle("💨 Wind Speed (m/s)"),
        infoRow("Average", "$avgWind"),
        infoRow("Minimum", "$minWind"),
        infoRow("Maximum", "$maxWind"),

        const SizedBox(height: 10),

        sectionTitle("⏱️ Pressure (Pa)"),
        infoRow("Average", "$avgPressure"),
        infoRow("Minimum", "$minPressure"),
        infoRow("Maximum", "$maxPressure"),

        const SizedBox(height: 10),

        sectionTitle("🧭 Compass Direction"),
        infoRow("Degrees", "$compassDegrees°"),
        infoRow("Point", compassPoint),
      ],
    ),
  );
}
