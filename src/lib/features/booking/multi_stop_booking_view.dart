import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MultiStopBookingView extends StatelessWidget {
  const MultiStopBookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MultiStopBookingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Multi-Stop Booking'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Stops',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.stops.length + 1,
                    itemBuilder: (context, index) => _buildStopField(
                      index,
                      model,
                      context,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: model.addStop,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Add Another Stop'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: model.canProceed ? model.proceed : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text('Proceed to Booking'),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => MultiStopBookingViewModel(),
    );
  }

  Widget _buildStopField(
      int index, MultiStopBookingViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: model.getControllerForIndex(index),
              decoration: InputDecoration(
                hintText: index == 0
                    ? 'Pickup Location'
                    : index == model.stops.length
                        ? 'Final Destination'
                        : 'Stop ${index}',
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => model.updateStop(index, value),
            ),
          ),
          if (index > 0 && index < model.stops.length)
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () => model.removeStop(index),
              color: Theme.of(context).errorColor,
            ),
        ],
      ),
    );
  }
}

class MultiStopBookingViewModel extends BaseViewModel {
  final List<String> stops = [''];
  final Map<int, TextEditingController> _controllers = {};

  bool get canProceed => stops.every((stop) => stop.isNotEmpty);

  TextEditingController getControllerForIndex(int index) {
    if (!_controllers.containsKey(index)) {
      _controllers[index] =
          TextEditingController(text: index < stops.length ? stops[index] : '');
    }
    return _controllers[index]!;
  }

  void addStop() {
    stops.add('');
    notifyListeners();
  }

  void removeStop(int index) {
    if (index > 0 && index < stops.length) {
      stops.removeAt(index);
      _controllers.remove(index);
      notifyListeners();
    }
  }

  void updateStop(int index, String value) {
    if (index < stops.length) {
      stops[index] = value;
      notifyListeners();
    }
  }

  void proceed() {
    // Navigation logic to be implemented
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }
}
