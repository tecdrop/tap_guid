// Copyright 2020-2025 Tecdrop SRL. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file or at https://www.tecdrop.com/tapguid/license/.

/// Defines some common types used in the application.
library;

enum UuidVersion { v1, v4, v6, v7, v8 }

/// The different formats in which a UUID can be displayed.
enum UuidFormat { standard, digits, braces, parentheses, urn, base64, base64url }
