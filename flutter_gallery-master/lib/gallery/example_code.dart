// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Note: This code is not runnable, it contains code snippets displayed in the
// gallery.

import 'package:flutter/material.dart';

class ButtonsDemo {
  void setState(VoidCallback callback) { }
  BuildContext context;

  void buttons() {

// START buttons_raised
// Create a raised button.
RaisedButton(
  child: const Text('BUTTON TITLE'),
  onPressed: () {
    // Perform some action
  }
);

// Create a disabled button.
// Buttons are disabled when onPressed isn't
// specified or is null.
const RaisedButton(
  child: Text('BUTTON TITLE'),
  onPressed: null
);

// Create a button with an icon and a
// title.
RaisedButton.icon(
  icon: const Icon(Icons.add, size: 18.0),
  label: const Text('BUTTON TITLE'),
  onPressed: () {
    // Perform some action
  },
);
// END

// START buttons_outline
// Create an outline button.
OutlineButton(
  child: const Text('BUTTON TITLE'),
  onPressed: () {
    // Perform some action
  }
);

// Create a disabled button.
// Buttons are disabled when onPressed isn't
// specified or is null.
const OutlineButton(
  child: Text('BUTTON TITLE'),
  onPressed: null
);

// Create a button with an icon and a
// title.
OutlineButton.icon(
  icon: const Icon(Icons.add, size: 18.0),
  label: const Text('BUTTON TITLE'),
  onPressed: () {
    // Perform some action
  },
);
// END

// START buttons_flat
// Create a flat button.
FlatButton(
  child: const Text('BUTTON TITLE'),
  onPressed: () {
    // Perform some action
  }
);

// Create a disabled button.
// Buttons are disabled when onPressed isn't
// specified or is null.
const FlatButton(
  child: Text('BUTTON TITLE'),
  onPressed: null
);
// END


// START buttons_dropdown
// Member variable holding value.
String dropdownValue;

// Dropdown button with string values.
DropdownButton<String>(
  value: dropdownValue,
  onChanged: (String newValue) {
    // null indicates the user didn't select a
    // new value.
    setState(() {
      if (newValue != null)
        dropdownValue = newValue;
    });
  },
  items: <String>['One', 'Two', 'Free', 'Four']
    .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value));
    })
    .toList()
);
// END


// START buttons_icon
// Member variable holding toggle value.
bool value;

// Toggleable icon button.
IconButton(
  icon: const Icon(Icons.thumb_up),
  onPressed: () {
    setState(() => value = !value);
  },
  color: value ? Theme.of(context).primaryColor : null
);
// END


// START buttons_action
// Floating action button in Scaffold.
Scaffold(
  appBar: AppBar(
    title: const Text('Demo')
  ),
  floatingActionButton: const FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: null
  )
);
// END
  }
}


class SelectionControls {
  void setState(VoidCallback callback) { }

  void selectionControls() {

// START selectioncontrols_checkbox
// Member variable holding the checkbox's value.
bool checkboxValue = false;

// Create a checkbox.
Checkbox(
  value: checkboxValue,
  onChanged: (bool value) {
    setState(() {
      checkboxValue = value;
    });
  },
);

// Create a tristate checkbox.
Checkbox(
  tristate: true,
  value: checkboxValue,
  onChanged: (bool value) {
    setState(() {
      checkboxValue = value;
    });
  },
);

// Create a disabled checkbox.
// Checkboxes are disabled when onChanged isn't
// specified or null.
const Checkbox(value: false, onChanged: null);
// END


// START selectioncontrols_radio
// Member variable holding value.
int radioValue = 0;

// Method setting value.
void handleRadioValueChanged(int value) {
  setState(() {
    radioValue = value;
  });
}

// Creates a set of radio buttons.
Row(
  children: <Widget>[
    Radio<int>(
      value: 0,
      groupValue: radioValue,
      onChanged: handleRadioValueChanged
    ),
    Radio<int>(
      value: 1,
      groupValue: radioValue,
      onChanged: handleRadioValueChanged
    ),
    Radio<int>(
      value: 2,
      groupValue: radioValue,
      onChanged: handleRadioValueChanged
    )
  ]
);

// Creates a disabled radio button.
const Radio<int>(
  value: 0,
  groupValue: 0,
  onChanged: null
);
// END


// START selectioncontrols_switch
// Member variable holding value.
bool switchValue = false;

// Create a switch.
Switch(
  value: switchValue,
  onChanged: (bool value) {
    setState(() {
      switchValue = value;
    }
  );
});

// Create a disabled switch.
// Switches are disabled when onChanged isn't
// specified or null.
const Switch(value: false, onChanged: null);
// END
  }
}


class GridLists {
  void gridlists() {
// START gridlists
// Creates a scrollable grid list with images
// loaded from the web.
GridView.count(
  crossAxisCount: 3,
  childAspectRatio: 1.0,
  padding: const EdgeInsets.all(4.0),
  mainAxisSpacing: 4.0,
  crossAxisSpacing: 4.0,
  children: <String>[
    'https://example.com/image-0.jpg',
    'https://example.com/image-1.jpg',
    'https://example.com/image-2.jpg',
    '...',
    'https://example.com/image-n.jpg'
  ].map<Widget>((String url) {
    return GridTile(
      footer: GridTileBar(
        title: Text(url)
      ),
      child: Image.network(url, fit: BoxFit.cover)
    );
  }).toList(),
);
// END
  }
}


class AnimatedImage {
  void animatedImage() {
// START animated_image
Image.network('https://example.com/animated-image.gif');
// END
  }
}
