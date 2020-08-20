import 'package:mega/components/creatable/creatable_button.dart';
import 'package:mega/components/creatable/creatable_form.dart';
import 'package:mega/components/creatable/creatable_grid.dart';
import 'package:mega/components/creatable/creatable_input.dart';
import 'package:mega/components/creatable/creatable_list.dart';
import 'package:mega/components/creatable/creatable_stuffing.dart';
import 'package:mega/components/creatable/creatable_text.dart';

const int grey = 0xFFF1F1F1;
const int transGrey = 0xC0F1F1F1;

const Map<String, dynamic> configurationMap = {
  'text': CreatableText.createText,
  'button': CreatableButton.createButton,
  'submit_button': CreatableButton.createButton,
  'form': CreatableForm.createForm,
  'input': CreatableInput.createInput,
  'list': CreatableList.createList,
  'grid': CreatableGrid.createGrid,

  'stuffing': CreatableStuffing.createStuffing,
};