import 'package:flutter/material.dart';
import 'package:pay_me/Modules/Beneficiary/model/beneficiary_model.dart';
import 'package:pay_me/Modules/Home/views/widgets/benefeciary_card.dart';

class BenefeciaryForm extends StatefulWidget {
  final Function(BeneficiaryModel) onSubmit;
  const BenefeciaryForm({super.key, required this.onSubmit});

  @override
  BenefeciaryFormState createState() => BenefeciaryFormState();
}

class BenefeciaryFormState extends State<BenefeciaryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Add new benefeciary',
            style: TextStyle(
                color: Color(0xff3A7BD5),
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else if (value.length > 20) {
                      return 'Name can not be more than 20 characters.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50.0),
                Center(
                    child: SubmitButton(
                  text: 'Add',
                  height: 40,
                  width: 100,
                  onTap: () {
                    var newBen = BeneficiaryModel(
                      id: DateTime.now().toString(),
                      name: _nameController.text,
                      mobile: _phoneController.text,
                    );
                    widget.onSubmit(newBen);
                  },
                )),
              ],
            ),
          )
        ]));
  }
}
