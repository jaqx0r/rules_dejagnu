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

"""This module implements the DejaGNU toolchain specification."""

load("@rules_dejagnu//dejagnu:providers.bzl", "DejaGNURuntestInfo", "DejaGNUToolchainInfo")

def _dejagnu_toolchain_info_impl(ctx):
    """Toolchain main implementation."""
    dejagnu = DejaGNUToolchainInfo(
        runtest = DejaGNURuntestInfo(
            runtest = ctx.attr.runtest.files_to_run,
            libs = ctx.attr.libs[DefaultInfo].files,
        ),
    )

    return [
        platform_common.ToolchainInfo(
            dejagnu_toolchain = dejagnu,
        ),
    ]

dejagnu_toolchain_info = rule(
    implementation = _dejagnu_toolchain_info_impl,
    doc = "Defines a DejaGNU toolchain.",
    attrs = {
        "runtest": attr.label(
            doc = "The `runtest` executable",
            mandatory = True,
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "libs": attr.label(
            doc = "The DejaGNU libraries.",
            mandatory = True,
        ),
    },
    provides = [platform_common.ToolchainInfo],
)
