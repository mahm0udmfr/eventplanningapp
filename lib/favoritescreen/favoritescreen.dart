import 'package:eventplanningapp/eventManageScreens/event_details_screen.dart';
import 'package:eventplanningapp/home/event_item_widget.dart';
import 'package:eventplanningapp/providers/event_list_provider.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:eventplanningapp/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColor.whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            CustomTextFormField(
                borderColor: AppColor.primarylLight,
                hintText: AppLocalizations.of(context)!.serach_event,
                hintStyle: TextStyle(
                    color: AppColor.primarylLight,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                prefixIcon: Image.asset(ImageAssets.iconSearch),
                style: TextStyle(
                    color: AppColor.primarylLight,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            Expanded(
              child: eventListProvider.eventList.isEmpty
                  ? Center(
                      child: Text("No Events In Favorite Yet"),
                    )
                  : ListView.builder(
                      itemCount: eventListProvider.eventListFavorite.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            
                      Navigator.of(context)
                          .pushNamed(EventDetailsScreen.routename,arguments: eventListProvider.eventList[index]);
                          },
                          child: EventItemWidget(
                            event: eventListProvider.eventListFavorite[index],
                            onTap: () {
                              eventListProvider.updateFavorite(
                                  eventListProvider.eventList[index]);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
