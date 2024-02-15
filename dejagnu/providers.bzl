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

"""Information providers for DejaGNU rules."""

DejaGNULibraryInfo = provider(
    doc = "DejaGnu Library provider.",
    fields = {
        "srcs": "Source files",
        "deps": "Dependencies",
    },
)

DejaGNURuntestInfo = provider(
    doc = "DejaGNU runtest tool provider.",
    fields = {
        "runtest": "A `FilesToRunProvider` for the `runtest` executable.",
        "libs": "DEJAGNULIBS standard library path.",
    },
)

DejaGNUToolchainInfo = provider(
    doc = "Information about how to invoke the DejaGNU executable.",
    fields = {
        "runtest": "A DejaGNURuntestInfo provider",
    },
)
