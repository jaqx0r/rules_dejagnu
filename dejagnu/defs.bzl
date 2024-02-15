# Copyright 2024 Jamie Wilkinson.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

"""Exported rules for DejaGNU bazel rules, the main library to include in user BUILD files."""

load("//dejagnu/rules:dejagnu.bzl", _dejagnu_test = "dejagnu_test")
load("//dejagnu/rules:dejagnu_library.bzl", _dejagnu_library = "dejagnu_library")

dejagnu_test = _dejagnu_test
dejagnu_library = _dejagnu_library
