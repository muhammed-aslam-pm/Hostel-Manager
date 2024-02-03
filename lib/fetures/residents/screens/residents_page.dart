// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hostel_management_app/commens/widgets/custom_dropdown_button.dart';
import 'package:hostel_management_app/fetures/residents/controllers/residents_controller.dart';
import 'package:hostel_management_app/fetures/residents/models/resident_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/image_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/fetures/residents/widgets/resident_loading_card.dart';
import 'package:hostel_management_app/fetures/residents/screens/resident_deatailes_screen.dart';
import 'package:hostel_management_app/fetures/residents/screens/residents_adding_form.dart';
import 'package:hostel_management_app/fetures/residents/widgets/residents_detailes_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ResidentsPage extends StatefulWidget {
  const ResidentsPage({super.key});

  @override
  State<ResidentsPage> createState() => _ResidentsPageState();
}

class _ResidentsPageState extends State<ResidentsPage> {
  @override
  void initState() {
    Provider.of<ResidentsController>(context, listen: false).fetchResidents();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ResidentsController>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhiteColor,
      appBar: AppBar(
        title: Text(
          "Residents Detailes",
          style: TextStyleConstants.homeMainTitle2,
        ),
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 0,
        leadingWidth: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Consumer<ResidentsController>(
                    builder: (context, value, child) => CustomDropdownButton(
                        selectedValue: value.selctedFilter,
                        items: value.filters,
                        onChanged: (p0) => value.selectFilter(p0),
                        height: 50,
                        width: MediaQuery.sizeOf(context).width * 0.4),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<ResidentsController>(
                builder: (context, value, child) => value.isResidentsLoading
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const ResidentsLoadingCard();
                        },
                        separatorBuilder: (context, index) => Divider(
                              color: ColorConstants.secondaryWhiteColor,
                              height: 10,
                            ),
                        itemCount: controller.residents.isEmpty
                            ? 10
                            : controller.residents.length)
                    : value.residents.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child:
                                    Image.asset(ImageConstants.emptyListImage),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text("Residents List is Empty !")
                            ],
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              ResidentModel resident =
                                  controller.residents[index];
                              return ResidentsDetailescard(
                                roomNumber: resident.roomNo,
                                joiningDate: DateFormat('dd MMM yyyy')
                                    .format(resident.checkIn),
                                name: resident.name,
                                isFeePaid: resident.isRentPaid,
                                image: resident.profilePic,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ResidentDetailesScreen(
                                        residentId: resident.id!,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                                  color: ColorConstants.secondaryWhiteColor,
                                  height: 10,
                                ),
                            itemCount: value.residents.length),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () async {
          await Provider.of<ResidentsController>(context, listen: false)
              .fetchVacantRooms();
          if (controller.vacantRoomNoList.isEmpty) {
            showDialog(
              context: context,
              builder: (context) =>
                  const AlertDialog(title: Text("No Vacant Rooms Available !")),
            );
          } else {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const ResidentsAddingPage(),
              ),
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              useSafeArea: true,
            );
          }
        },
        backgroundColor: ColorConstants.primaryWhiteColor,
        elevation: 50,
        child: Icon(
          Icons.person_add_alt_1,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }
}
