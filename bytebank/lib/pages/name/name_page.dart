import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bytebank/themes/colors_app.dart';
import 'package:bytebank/themes/constants.dart';
import 'package:bytebank/widgets/custom_snackbar_widget.dart';

import '../../models/name_model.dart';

class NamePage extends StatelessWidget {
  NamePage({Key? key}) : super(key: key);

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = context.read<NameCubit>().state;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Change name'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(17),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Desired name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: paddingSize / 2),
                Material(
                  color: Theme.of(context).primaryColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        final name = _nameController.text;
                        context.read<NameCubit>().change(name);
                        CustomSnackbarWidget.show(
                          context: context,
                          message: 'Name changed',
                          color: successColor,
                        );
                      },
                      child: const SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          'CHANGE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )),
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
