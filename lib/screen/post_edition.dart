import 'package:flutter/material.dart';

void showPostEditionDialog({
  required BuildContext context,
  required String dialogTitle,
  required Function onConfirm,
  String title = '',
  String description = ''
}) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(dialogTitle),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez préciser le titre du post';
                  }
                  return null;
                },
                onChanged: (String? value) => {
                  if (value != null) {
                    title = value
                  }
                }
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true
                ),
                maxLines: 5,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez préciser la description du post';
                  }
                  return null;
                },
                onSaved: (String? value) => {
                  if (value != null) {
                    description = value
                  }
                }
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Annuler')
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState?.save(),
                          onConfirm(context, title, description),
                          Navigator.of(context).pop()
                        }
                      },
                      child: const Text('Confirmer')
                    ),
                  ],
                ),
              )
            ]
          ),
        ),
      );
    }
  );
}