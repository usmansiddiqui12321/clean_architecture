import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:clean_architecture/Constants/app_colors.dart';
import 'package:clean_architecture/widgets/hover_card.dart';
import 'package:contextmenu/contextmenu.dart';

// Pharmaceutical Model
class Pharmaceutical {
  final String name;
  final double sales;
  final String description;

  Pharmaceutical(
      {required this.name, required this.sales, required this.description});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isLoading = false;
  final List<Pharmaceutical> pharmaceuticals = [
    Pharmaceutical(
        name: 'Paracetamol',
        sales: 5.2,
        description: 'Pain reliever and fever reducer'),
    Pharmaceutical(
        name: 'Ibuprofen',
        sales: 4.8,
        description: 'Anti-inflammatory painkiller'),
    Pharmaceutical(
        name: 'Amoxicillin',
        sales: 6.1,
        description: 'Common antibiotic for infections'),
    Pharmaceutical(
        name: 'Metformin',
        sales: 7.4,
        description: 'Used for diabetes management'),
    Pharmaceutical(
        name: 'Atorvastatin',
        sales: 8.0,
        description: 'Cholesterol-lowering medication'),
    Pharmaceutical(
        name: 'Omeprazole', sales: 6.5, description: 'Reduces stomach acid'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = true;
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isLoading = false;
          });
        });
      });
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeTransition(
          opacity: _animation,
          child: const Text('Pharmaceutical Dashboard'),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(_controller),
                    child: const Text(
                      'Sales Overview',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Grid Section
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: pharmaceuticals.length,
                    itemBuilder: (context, index) {
                      return FadeTransition(
                        opacity: _animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.5),
                            end: Offset.zero,
                          ).animate(_animation),
                          child: HoverCard(
                            text:
                                '${pharmaceuticals[index].name} \n Sales: \$${pharmaceuticals[index].sales}M',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 250,
                    child: ScaleTransition(
                      scale: _animation,
                      child: FadeTransition(
                        opacity: _animation,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: LineChart(
                              LineChartData(
                                backgroundColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppColors.surface
                                    : AppColors.backgroundLight,
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: true,
                                  horizontalInterval: 1,
                                  verticalInterval: 1,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: Colors.grey.withValues(alpha: 0.3),
                                      strokeWidth: 1,
                                    );
                                  },
                                  getDrawingVerticalLine: (value) {
                                    return FlLine(
                                      color: Colors.grey.withValues(alpha: 0.3),
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 22,
                                      interval: 1,
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        const style = TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        );
                                        String text;
                                        switch (value.toInt()) {
                                          case 0:
                                            text = 'Jan';
                                            break;
                                          case 1:
                                            text = 'Feb';
                                            break;
                                          case 2:
                                            text = 'Mar';
                                            break;
                                          case 3:
                                            text = 'Apr';
                                            break;
                                          case 4:
                                            text = 'May';
                                            break;
                                          case 5:
                                            text = 'Jun';
                                            break;
                                          default:
                                            text = '';
                                            break;
                                        }
                                        return Text(text, style: style);
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      reservedSize: 40,
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        const style = TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        );
                                        return Text(
                                          value.toInt().toString(),
                                          style: style,
                                          textAlign: TextAlign.left,
                                        );
                                      },
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    color: AppColors.primary,
                                    spots: pharmaceuticals
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return FlSpot(entry.key.toDouble(),
                                          entry.value.sales);
                                    }).toList(),
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
                    ),
                  ),
                  // Graph Section
                  const SizedBox(height: 20),

                  // List Section
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: pharmaceuticals.length,
                    itemBuilder: (context, index) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _controller,
                          curve: Interval(
                            0.1 * index,
                            1.0,
                            curve: Curves.easeInOut,
                          ),
                        )),
                        child: ContextMenuArea(
                          builder: (context) => [
                            ListTile(
                              leading:
                                  Icon(Icons.edit, color: AppColors.primary),
                              title: Text('Edit'),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(Icons.delete, color: Colors.red),
                              title: Text('Delete'),
                              onTap: () {},
                            ),
                          ],
                          child: Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              title: Text(
                                pharmaceuticals[index].name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                pharmaceuticals[index].description,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
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
