// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

/// Internal utility functions for the app.
library;

/// Returns a mock UUID string based on the provided index.
String getMockUuid(int index) {
  const List<String> mockUuids = [
    'd7b47c99-24be-4218-abec-03ff9e83f2f1',
    'cd1b14ca-bc3e-4b0e-bf5a-e282444aeecc',
    'a3ba07b1-9ac4-4fd3-8980-59743ae3d941',
    '9bbd723e-c60b-40ce-b3d1-c82a288d9208',
    'e249781f-ae87-481d-bafd-a4df2f8b70fc',
  ];

  return mockUuids[index];
}
