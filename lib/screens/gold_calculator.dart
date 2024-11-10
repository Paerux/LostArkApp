import 'package:flutter/material.dart';
import 'package:lost_time/config/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GoldCalculatorScreen extends StatefulWidget {
  const GoldCalculatorScreen({super.key});

  @override
  GoldCalculatorScreenState createState() => GoldCalculatorScreenState();
}

class GoldCalculatorScreenState extends State<GoldCalculatorScreen> {
  final TextEditingController marketPriceController = TextEditingController();
  int? marketPrice;
  int profit4Player = 0;
  int profit8Player = 0;
  int profit16Player = 0;
  int bid4Player = 0;
  int bid8Player = 0;
  int bid16Player = 0;

  void calculateProfit() {
    String marketPriceString = marketPriceController.text;
    marketPrice = int.tryParse(marketPriceString);

    // Check if marketPrice is null or empty
    if (marketPrice == null || marketPrice == 0) {
      // Show an error or return early if the market price is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid market price')),
      );
      return;
    }

    setState(() {
      // Adjusted market price
      int adjustedMarketPrice = (marketPrice! * 0.95).round();

      // Calculate profit per player (rounding after dividing)
      profit4Player = (adjustedMarketPrice / 4).floor();
      profit8Player = (adjustedMarketPrice / 8).floor();
      profit16Player = (adjustedMarketPrice / 16).floor();

      // Calculate the bid as adjusted market price minus profit per player
      bid4Player = (adjustedMarketPrice - (adjustedMarketPrice / 4).round());
      bid8Player = (adjustedMarketPrice - (adjustedMarketPrice / 8).round());
      bid16Player = (adjustedMarketPrice - (adjustedMarketPrice / 16).round());
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit Calculator'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the column content
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center the column content
            children: [
              Column(
                children: [
                  const Text(
                    'Enter Market Price',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Market Price Input Field
                  TextField(
                    controller: marketPriceController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Centered Calculate Button
              ElevatedButton(
                onPressed: calculateProfit,
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 16),

              // Responsive Grid for cards
              Expanded(
                child: StaggeredGrid.count(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 3 : 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: _buildPlayerCard(
                          context, 4, bid4Player, profit4Player),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: _buildPlayerCard(
                          context, 8, bid8Player, profit8Player),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: _buildPlayerCard(
                          context, 16, bid16Player, profit16Player),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerCard(
      BuildContext context, int playerCount, int bid, int profit) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      elevation: 4,
      color: themeProvider.currentThemeData.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              '$playerCount Player',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color:
                    themeProvider.currentThemeData.textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bid: ${bid > 0 ? bid : 'Enter market price and calculate'}',
              style: TextStyle(
                fontSize: 14,
                color:
                    themeProvider.currentThemeData.textTheme.bodyMedium?.color,
              ),
            ),
            // Label and Profit per Player Field
            Text(
              'Profit per player: ${profit > 0 ? profit.toStringAsFixed(0) : 'Enter market price and calculate'}',
              style: TextStyle(
                fontSize: 14,
                color:
                    themeProvider.currentThemeData.textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 8),
            // Label and Bid Field
          ],
        ),
      ),
    );
  }
}
