import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/screens/home/partials/contact_fields.dart';
import 'package:portfolio/screens/home/partials/section_wrapper.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController projectDescriptionController = TextEditingController();

  selectCountry() {
    ThemeData theme = Theme.of(context);
    showCountryPicker(
      context: context,
      favorite: <String>['VN'],
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ),
      onSelect: (Country country) => countryController.text = country.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return SectionWrapper(
      child: Container(
        height: size.height - 240,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(image: AssetImage('assets/images/contact_bg.jpeg'), fit: BoxFit.cover, opacity: 0.2)
        ),
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 96.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Get in touch', style: theme.textTheme.headlineLarge?.copyWith(color: theme.colorScheme.onPrimary)),
                    SizedBox(height: 24),
                    Text(
                      'Have a project in mind? Looking to partner or work together? Reach out through the form and I\'ll get back to you in the next 24 hours',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary)
                    ),
                    SizedBox(height: 56),
                    Row(
                      children: [
                        Icon(Icons.email_rounded, color: theme.colorScheme.onPrimary),
                        SizedBox(width: 8),
                        Text('binhnt.010896@gmail.com', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContactTextField(title: 'Your Name', controller: nameController, helper: 'Enter your name',),
                    ContactTextField(title: 'Your E-mail', controller: emailController, helper: 'Enter your email'),
                    ContactTextField(title: 'Where you\'re from', controller: countryController, helper: 'Click to choose', onPress: selectCountry, enabled: false,),
                    ContactTextField(title: 'Tell me a bit more what you are looking to create', controller: projectDescriptionController, helper: 'Tell me, I won\'t spill ;)', maxLine: 5),
                    SizedBox(height: 8),
                    MaterialButton(
                        color: Theme.of(context).colorScheme.secondary,
                        textColor: Theme.of(context).colorScheme.onSecondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        elevation: 5,
                        onPressed: () {

                          print(nameController.text);
                          print(emailController.text);
                          print(projectDescriptionController.text);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: Text('Submit Now', style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
