import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/controllers/contact_controller.dart';
import 'package:portfolio/helpers/misc.dart';
import 'package:portfolio/screens/home/partials/contact_fields.dart';
import 'package:portfolio/services/supabase_service.dart';
import 'package:portfolio/widgets/action_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContactModal extends StatefulWidget {
  const ContactModal({Key? key}) : super(key: key);

  @override
  State<ContactModal> createState() => _ContactModalState();
}

class _ContactModalState extends State<ContactModal> {

  final _formKey = GlobalKey<FormState>();

  final ContactController _contactController = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    return Obx(() => Container(
        margin: isSP ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: (size.width-600)/2),
        padding: EdgeInsets.all(24),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact me', style: theme.textTheme.headlineMedium),
                  Text('Thanks for taking the time to reach out. How can I help you today?'),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: ContactTextField(
                          title: 'Name',
                          helper: 'Your Name',
                          controller: _contactController.getNameController(),
                        ),
                      ),
                      SizedBox(width: 24),
                      Flexible(
                        flex: 3,
                        child: ContactTextField(
                          title: 'Email',
                          helper: 'Your Email',
                          controller: _contactController.getEmailController(),
                        ),
                      )
                    ],
                  ),
                  ContactTextField(
                    title: 'Message',
                    helper: 'Enter your message...',
                    maxLine: 5,
                    controller: _contactController.getMessageController(),
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ActionButton(
                      text: 'Submit',
                      loading: _contactController.getFormLoading(),
                      padding: EdgeInsets.only(left: 24, right: 20, top: 16, bottom: 16),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _contactController.submitForm(context);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
