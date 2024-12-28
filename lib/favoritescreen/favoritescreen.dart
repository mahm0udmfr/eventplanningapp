import 'package:eventplanningapp/home/event_item_widget.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:eventplanningapp/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return EventItemWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
