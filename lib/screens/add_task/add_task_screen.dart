import 'package:cs_three_things/base/resources/app_styles.dart';
import 'package:cs_three_things/screens/add_task/widgets/priority_item_widget.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../base/utils/config.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // GlobalKey required by key
  final _taskFormKey = GlobalKey<FormState>();
  // text controller for taskName
  final TextEditingController taskNameController = TextEditingController();
  // text controller for taskNote
  final TextEditingController taskNoteController = TextEditingController();
  // variable to display height of taskNote field
  final height = 160.00;
  // dueDate
  DateTime? selectedDate = DateTime.now();
  // TextFieldTags
  late StringTagController _stringTagController;
  late double _distanceToField;
  int maxTagLimit = 3;

  // task Priority
  int selectedPriority = 0;

  //Dropdown menu
  final TextEditingController areaMenuController = TextEditingController();
  String? selectedArea;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
  }

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New Task',
          style: AppStyles.headlineStyle1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _taskFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TASK NAME section
              TextFormField(
                cursorHeight: 22,
                textAlignVertical: TextAlignVertical.bottom,
                controller: taskNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter a task name';
                  }
                  return null;
                },
                style: AppStyles.textInputStyle1,
                decoration: InputDecoration(
                  label: const Text('Task Name'),
                  hintText: 'enter a task name',
                  hintStyle: AppStyles.textHintStyle,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: AppStyles.inputBorderStyle,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: AppStyles.focusedBorderStyle,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // TASK NOTE section
              SizedBox(
                height: height,
                child: TextFormField(
                  maxLines: height ~/ 20,
                  controller: taskNoteController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter a task description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Task Note'),
                    hintText: 'enter a description',
                    hintStyle: AppStyles.textHintStyle,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: AppStyles.inputBorderStyle,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: AppStyles.focusedBorderStyle,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // TASK DUEDATE -
              // TODO - change showDatePicker color style
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppStyles.unselectedIconColor),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat('EEEE, d MMMM yyyy').format(selectedDate!),
                        style: AppStyles.textInputStyle2,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          helpText: 'Select Task Due Date',
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          selectedDate = picked;
                          setState(() {});
                        }
                      },
                      icon: const Icon(
                        FluentSystemIcons.ic_fluent_calendar_month_regular,
                        size: 34,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // TASK TAGS
              // TODO - tag field label acts strange
              TextFieldTags<String>(
                textfieldTagsController: _stringTagController,
                initialTags: const [],
                textSeparators: const [' ', ','],
                letterCase: LetterCase.normal,
                validator: (String tag) {
                  print('validator ${_stringTagController.getTags}');
                  if (tag.isEmpty) {
                    return 'Enter your tags...';
                  }
                  if (_stringTagController.getTags!.length >= maxTagLimit) {
                    return 'Only $maxTagLimit tags allowed';
                  }
                  return null;
                },
                inputFieldBuilder: (context, inputFieldValues) {
                  return TextField(
                    onTap: () {
                      _stringTagController.getFocusNode?.requestFocus();
                    },
                    controller: inputFieldValues.textEditingController,
                    focusNode: inputFieldValues.focusNode,
                    decoration: InputDecoration(
                      isDense: false,
                      // design for border
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: AppStyles.inputBorderStyle,
                      ),
                      // design for border if active
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: AppStyles.focusedBorderStyle,
                      ),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelText: 'Task Tags',
                      // label: const Text(
                      //   'Task Tags',
                      //   softWrap: true,
                      //   overflow: TextOverflow.visible,
                      // ),
                      labelStyle: AppStyles.textHintStyle,
                      hintText: inputFieldValues.tags.isNotEmpty
                          ? ''
                          : "Enter tag/s...",
                      hintStyle: AppStyles.textHintStyle,
                      errorText: inputFieldValues.error,
                      prefixIconConstraints:
                          BoxConstraints(maxWidth: _distanceToField * 0.8),
                      prefixIcon: inputFieldValues.tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: inputFieldValues.tagScrollController,
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                // padding of whole container
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 5),
                                child: Wrap(
                                  runSpacing: 0.0,
                                  spacing: 2.0,
                                  children:
                                      inputFieldValues.tags.map((String tag) {
                                    print(tag);
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                        color: Colors.blueGrey.shade400,
                                      ),
                                      // margin around each tag
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3.0, vertical: 8),
                                      // padding inside each tag
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              '#$tag',
                                              style: AppStyles
                                                  .textTagInputStyle3
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                            onTap: () {
                                              print("$tag selected");
                                            },
                                          ),
                                          const SizedBox(width: 5.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 18.0,
                                              color: Color.fromARGB(
                                                  255, 239, 234, 234),
                                            ),
                                            onTap: () {
                                              inputFieldValues
                                                  .onTagRemoved(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          : null,
                    ),
                    onChanged: inputFieldValues.onTagChanged,
                    onSubmitted: inputFieldValues.onTagSubmitted,
                  );
                },
              ),

              const SizedBox(
                height: 20,
              ),
              // TASK PRIORITY AND AREA
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: GridView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: priorities.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPriority = index;
                              });
                            },
                            child: PriorityItemWidget(
                              selectedPriority: selectedPriority,
                              index: index,
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // TODO - setup user can add new area
                  DropdownMenu<String>(
                      menuStyle: const MenuStyle(
                        side: MaterialStatePropertyAll<BorderSide?>(
                          BorderSide(width: 0.25),
                        ),
                        elevation: MaterialStatePropertyAll(0),
                        shadowColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: AppStyles.focusedBorderStyle,
                          ),
                          contentPadding: const EdgeInsets.all(5)),
                      width: 200,
                      initialSelection: areas.first['area'],
                      controller: areaMenuController,
                      requestFocusOnTap: true,
                      label: const Text('Area'),
                      onSelected: (String? newValue) {
                        setState(() {
                          selectedArea = newValue;
                          print(selectedArea);
                        });
                      },
                      dropdownMenuEntries: areas.map((area) {
                        return DropdownMenuEntry<String>(
                          value: area['area'],
                          label: area['area'],
                          leadingIcon: area['icon'],
                          style: MenuItemButton.styleFrom(
                              backgroundColor: Colors.white,
                              textStyle: AppStyles.textLabelStyle1),
                        );
                      }).toList()),
                ],
              ),

              const Expanded(
                child: SizedBox(
                  height: 40,
                ),
              ),

              // Add New Task Button
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 1, 50)),
                onPressed: () {},
                child: Text(
                  'Add New Task',
                  style: AppStyles.textLabelStyle2,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
