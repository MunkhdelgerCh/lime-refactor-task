import 'package:flutter/material.dart';
import '../providers/data_provider.dart';
import 'package:get/get.dart';

final DataModel dataModel = Get.find<DataModel>();

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Refactor Task App')),
      body: Column(
        children: [
          // Toggle buttons for switching between list and grid view
          _buildToggleButtons(context),
          // Display the list or grid view based on the selected mode
          _buildBody(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: dataModel.fetchAndStoreItems,
        tooltip: 'Fetch Data',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  // Widget for the toggle buttons
  Widget _buildToggleButtons(BuildContext context) {
    return Obx(() {
      return ToggleButtons(
        // isSelected list to manage the selected state of each button
        isSelected: [
          dataModel.viewMode.value == ViewMode.list,
          dataModel.viewMode.value == ViewMode.grid
        ],
        onPressed: (int index) {
          // Toggle the view mode based on the selected button
          dataModel.viewMode.value = index == 0 ? ViewMode.list : ViewMode.grid;
        },
        children: [
          // List view icon
          Icon(
            Icons.list,
            color: dataModel.viewMode.value == ViewMode.list
                ? Theme.of(context).primaryIconTheme.color
                : Theme.of(context).unselectedWidgetColor,
          ),
          // Grid view icon
          Icon(
            Icons.grid_on,
            color: dataModel.viewMode.value == ViewMode.grid
                ? Theme.of(context).primaryIconTheme.color
                : Theme.of(context).unselectedWidgetColor,
          ),
        ],
      );
    });
  }

  // Widget for the main body content (list or grid view)
  Widget _buildBody() {
    return Obx(
      () {
        if (dataModel.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // Display either a grid or list view based on the selected mode
          return _buildListGridView(dataModel.viewMode.value);
        }
      },
    );
  }

  // Widget to build either a list or grid view based on the selected mode
  Widget _buildListGridView(viewMode) {
    return Expanded(
      child: viewMode == ViewMode.grid
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: dataModel.items.length,
              itemBuilder: (context, index) {
                final item = dataModel.items[index];
                return Card(
                  child: Column(
                    children: [
                      Text(item.title ?? ''),
                      Text(item.description ?? ''),
                    ],
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: dataModel.items.length,
              itemBuilder: (context, index) {
                final item = dataModel.items[index];
                return ListTile(
                  title: Text(item.title ?? ''),
                  subtitle: Text(item.description ?? ''),
                );
              },
            ),
    );
  }
}
