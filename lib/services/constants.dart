import 'package:mega/components/creatable/creatable_button.dart';
import 'package:mega/components/creatable/creatable_form.dart';
import 'package:mega/components/creatable/creatable_data_grid.dart';
import 'package:mega/components/creatable/creatable_input.dart';
import 'package:mega/components/creatable/creatable_data_list.dart';
import 'package:mega/components/creatable/creatable_stuffing.dart';
import 'package:mega/components/creatable/creatable_text.dart';

/// Grey color hex
const int grey = 0xFFF1F1F1;

/// Transparent grey color hex
const int transGrey = 0xC0F1F1F1;

/// Map of widgets to string name
///
/// Used in the feature code interpreter to
/// get widget from string representations
const Map<String, dynamic> configurationMap = {
  'text': CreatableText.createText,
  'button': CreatableButton.createButton,
  'form': CreatableForm.createForm,
  'input': CreatableInput.createInput,
  'list': CreatableDataList.createList,
  'grid': CreatableDataGrid.createGrid,
  'stuffing': CreatableStuffing.createStuffing,
};