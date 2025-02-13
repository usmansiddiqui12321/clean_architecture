import 'package:clean_architecture/Constants/app_colors.dart';
import 'package:clean_architecture/widgets/hover_card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:contextmenu/contextmenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> gridItems =
      List.generate(6, (index) => 'Grid Item ${index + 1}');
  final List<String> listItems =
      List.generate(10, (index) => 'List Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Grid Section
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: gridItems.length,
              itemBuilder: (context, index) {
                return HoverCard(
                  text: gridItems[index],
                );
              },
            ),
            const SizedBox(height: 20),
            // Graph Section
            SizedBox(
              height: 250,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.surface
                              : AppColors.backgroundLight,
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          color: AppColors.primary,
                          spots: [
                            FlSpot(0, 1),
                            FlSpot(1, 3),
                            FlSpot(2, 7),
                            FlSpot(3, 5),
                            FlSpot(4, 8),
                            FlSpot(5, 6),
                          ],
                          isCurved: true,
                          barWidth: 4,
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // List Section
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return ContextMenuArea(
                  builder: (context) => [
                    ListTile(
                      title: Text('Option 1'),
                      onTap: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Whatever')));
                      },
                    ),
                    ListTile(
                      title: Text('Option 2'),
                      onTap: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Whatever')));
                      },
                    ),
                    ListTile(
                      title: Text('Option 3'),
                      onTap: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Whatever')));
                      },
                    ),
                  ],
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        listItems[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Text(
                        'Additional details or description',
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
