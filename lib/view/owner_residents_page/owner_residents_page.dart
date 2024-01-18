import 'package:flutter/material.dart';
import 'package:hostel_management_app/controller/residents/residents_controller.dart';
import 'package:hostel_management_app/model/resident_model.dart';
import 'package:hostel_management_app/utils/color_constants.dart';
import 'package:hostel_management_app/utils/text_style_constatnts.dart';
import 'package:hostel_management_app/view/global_widgets/date_sorting_button.dart';
import 'package:hostel_management_app/view/resident_detailes_screen/resident_deatailes_screen.dart';
import 'package:hostel_management_app/view/residents_adding_form/residents_adding_form.dart';
import 'package:hostel_management_app/view/owner_residents_page/widgets/residents_detailes_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OwnerResidentsPage extends StatefulWidget {
  const OwnerResidentsPage({super.key});

  @override
  State<OwnerResidentsPage> createState() => _OwnerResidentsPageState();
}

class _OwnerResidentsPageState extends State<OwnerResidentsPage> {
  @override
  void initState() {
    Provider.of<ResidentsController>(context, listen: false).fetchResidents();
    // TODO: implement initState
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [DateSortingButton(title: "All Residents")],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<ResidentsController>(
                builder: (context, value, child) => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ResidentModel resident = controller.residents[index];
                      return ResidentsDetailescard(
                        roomNumber: resident.roomNo,
                        joiningDate:
                            DateFormat('dd MMM yyyy').format(resident.checkIn),
                        name: resident.name,
                        isFeePaid: resident.isRentPaid,
                        image: resident.profilePic,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResidentDetailesScreen(
                                  index: index,
                                ),
                              ));
                        },
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          color: ColorConstants.secondaryWhiteColor,
                          height: 10,
                        ),
                    itemCount: controller.residents.length),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          Provider.of<ResidentsController>(context, listen: false)
              .fetchVacantRooms();
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const ResidentsAddingPage(),
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            useSafeArea: true,
          );
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
