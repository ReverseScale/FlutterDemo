// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:veggieseasons/styles.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  SearchBar({
    @required this.controller,
    @required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.searchBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4.0,
          vertical: 8.0,
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.search,
              color: Styles.searchIconColor,
            ),
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                style: Styles.searchText,
                cursorColor: Styles.searchCursorColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.clear();
              },
              child: Icon(
                CupertinoIcons.clear_thick_circled,
                color: Styles.searchIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
