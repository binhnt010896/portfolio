import 'package:flutter/material.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/screens/home/partials/contact_fields.dart';
import 'package:portfolio/widgets/action_button.dart';

class ContactModal extends StatefulWidget {
  const ContactModal({Key? key}) : super(key: key);

  @override
  State<ContactModal> createState() => _ContactModalState();
}

class _ContactModalState extends State<ContactModal> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: (size.width-600)/2),
      padding: EdgeInsets.all(24),
      child: Center(
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
                    ),
                  ),
                  SizedBox(width: 24),
                  Flexible(
                    flex: 3,
                    child: ContactTextField(
                      title: 'Email',
                      helper: 'Your Email',
                    ),
                  )
                ],
              ),
              ContactTextField(
                title: 'Message',
                helper: 'Enter your message...',
                maxLine: 5,
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ActionButton(
                  text: 'Submit',
                  padding: EdgeInsets.only(left: 24, right: 20, top: 16, bottom: 16),
                  onPressed: () {

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
