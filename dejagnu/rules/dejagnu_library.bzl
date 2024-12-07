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

"""Dejagnu Libraries."""

load("//dejagnu:providers.bzl", "DejaGNULibraryInfo")

def _dejagnu_lib_impl(ctx):
    """Implementation of dejagnu lib."""
    runfiles = ctx.runfiles(files = ctx.files.srcs)
    runfiles = runfiles.merge_all([
        dep[DefaultInfo].default_runfiles
        for dep in ctx.attr.deps
    ])
    return [
        DefaultInfo(runfiles = runfiles),
        DejaGNULibraryInfo(),
        coverage_common.instrumented_files_info(
            ctx,
            source_attributes = ["srcs"],
            dependency_attributes = ["deps"],
        ),
    ]

dejagnu_library = rule(
    implementation = _dejagnu_lib_impl,
    attrs = {
        "srcs": attr.label_list(
            doc = "Program source files for this library.",
            allow_files = [".exp"],
        ),
        "deps": attr.label_list(providers = [DejaGNULibraryInfo], doc = "DejaGNU libraries used by this library."),
    },
    doc = """\
A DejaGNU Library.

This rule specifies `expect` program text that can be reused between testsuites.
""",
)
