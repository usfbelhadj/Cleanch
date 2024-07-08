// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../utils/translation/translation.dart';
import 'controller.dart';
import 'getFromApi.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class InterestPageController extends GetxController {
  RxBool isLoading = false.obs;
  final LocationController _localController = Get.put(LocationController());

  bool isloadind = false;

  RxList<String> selectedRegions = <String>[].obs;
  List<String> selectedShortNames = <String>[];
  List<String> selectedremovedList = <String>[];
  RxList<String> selectedFrontiers = <String>[].obs;
  RxList<String> selectedAutoroutes = <String>[].obs;
  RxList<String> selectedremovedRegionList = <String>[].obs;
  RxList<String> selectedremovedForntiersList = <String>[].obs;
  RxList<String> selectedremovedAutoroutesList = <String>[].obs;

  RxList<dynamic> region = <dynamic>[].obs;

  RxList<String> regions = <String>[].obs;
  RxList<String> regionsSelected = <String>[].obs;
  RxList<String> frontierSelected = <String>[].obs;
  RxList<String> autorouteSelected = <String>[].obs;
  RxList<String> frontiers = <String>[].obs;
  RxList<String> autoroutes = <String>[].obs;
  Map<String, dynamic> regFound = <String, dynamic>{};

  Future<void> fetchData() async {
    isLoading.value = true;
    region.assignAll(await _localController.fetchRegions());
    frontiers.assignAll(await _localController.fetchFrontiers());
    autoroutes.assignAll(await _localController.fetchAutoroutes());

    regFound = await _localController.getLocationOfuser();

    regions.assignAll(region
        .map((element) => '${element['short_name']} - ${element['name']}'));

    for (var reg in regFound['preferred_locations']) {
      for (var reg2 in regions) {
        if (reg2.substring(0, 2) == reg) {
          regionsSelected.add(reg2);
        }
      }
    }
    ;
    for (var reg in regFound['preferred_frontier']) {
      frontierSelected.add(reg);
    }
    ;
    for (var reg in regFound['preferred_autoroute']) {
      autorouteSelected.add(reg);
    }
    ;
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
}

final box = GetStorage();

class InterestPage extends StatelessWidget {
  final InterestPageController controller = Get.put(InterestPageController());
  final UserInterestsController myController =
      Get.put(UserInterestsController());

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 150, 222, 255),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
          // if dark mode color is white else color is black
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        title: Obx(() {
          return Text(
            tr('selectionPage'),
            style: Theme.of(context).textTheme.headlineSmall,
          );
        }),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: SpinKitPouringHourGlass(
                  color: Colors.blue,
                  size: 50.0,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CheckboxList(
                          label: tr('SelectRegions'),
                          items: controller.regions,
                          selectedList: controller.selectedRegions,
                          selectedremovedList:
                              controller.selectedremovedRegionList,
                        ),
                        CheckboxList(
                          label: tr('SelectFrontiers'),
                          items: controller.frontiers,
                          selectedList: controller.selectedFrontiers,
                          selectedremovedList:
                              controller.selectedremovedForntiersList,
                        ),
                        CheckboxList(
                          label: tr('SelectAutoroutes'),
                          items: controller.autoroutes,
                          selectedList: controller.selectedAutoroutes,
                          selectedremovedList:
                              controller.selectedremovedAutoroutesList,
                        ),
                        SizedBox(height: 16.0),
                      ],
                    )),
              ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 33, 243, 138),
        ),
        onPressed: () async {
          var removedList = box.read('selectedremovedList');
          controller.selectedremovedList.clear();
          for (var regg in controller.selectedRegions) {
            controller.selectedShortNames.add(regg.substring(0, 2));
          }
          if (removedList != null) {
            for (var region in removedList) {
              controller.selectedremovedList.add(region.substring(0, 2));
            }
            await myController.rmInterestfron(removedList);
            await myController.rmAut(removedList);
          }

          await myController.rmRegInterest(controller.selectedremovedList);

          await myController.addRegInterest(controller.selectedShortNames);

          await myController.addInterestFor(controller.selectedFrontiers);

          await myController.addInterestAut(controller.selectedAutoroutes);

          Get.defaultDialog(
            title: 'Success',
            middleText: 'Your interests have been updated',
            textConfirm: 'OK',
            onConfirm: () {
              Get.back();
              Get.back();
            },
          );
        },
        child: Text('Save'),
      ).paddingOnly(top: 16.0, right: 16.0, left: 16.0),
    );
  }
}

@override
class CheckboxList extends StatelessWidget {
  final LocationController _localController = Get.put(LocationController());
  final InterestPageController _interestLocal =
      Get.put(InterestPageController());
  final String label;
  late RxList<String> items = <String>[].obs;
  final RxList<dynamic> selectedList;
  final RxList<dynamic> selectedremovedList = <dynamic>[].obs;

  CheckboxList({
    Key? key,
    required this.label,
    required this.items,
    required this.selectedList,
    required RxList<String> selectedremovedList,
  }) : super(key: key);

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Obx(
          () => Column(
            children: items.map(
              (String item) {
                if (_interestLocal.regionsSelected.contains(item) == true &&
                    selectedList.contains(item) == false) {
                  selectedList.add(item);
                }
                if (_interestLocal.frontierSelected.contains(item) == true &&
                    selectedList.contains(item) == false) {
                  selectedList.add(item);
                }
                if (_interestLocal.autorouteSelected.contains(item) == true &&
                    selectedList.contains(item) == false) {
                  selectedList.add(item);
                }
                var isItemChecked = selectedList.contains(item);

                return CheckboxListTile(
                  title: Text(item),
                  value: isItemChecked,
                  onChanged: (checkValue) {
                    if (checkValue == true) {
                      selectedList.add(item);
                    } else {
                      selectedremovedList.add(item);
                      box.write('selectedremovedList', selectedremovedList);
                      selectedList.remove(item);
                      _interestLocal.regionsSelected.remove(item);

                      _interestLocal.frontierSelected.remove(item);

                      _interestLocal.autorouteSelected.remove(item);

                      _interestLocal.regFound.remove(item);
                    }
                    _interestLocal.regionsSelected.clear();
                  },
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
