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

"""Helper for getting the current toolchain."""

DEJAGNU_TOOLCHAIN_TYPE = "@rules_dejagnu//dejagnu:toolchain_type"

def dejagnu_toolchain(ctx):
    """Returns the current [`DejaGNUToolchainInfo`](#DejaGNUToolchainInfo).

    Args:
       ctx: A rule context, where the rule has a toolchain dependency on [`DEJAGNU_TOOLCHAIN_TYPE`](#DEJAGNU_TOOLCHAIN_TYPE).

    Returns:
       A [`DejaGNUToolchainInfo`](#DejaGNUToolchainInfo).
    """
    return ctx.toolchains[DEJAGNU_TOOLCHAIN_TYPE].dejagnu_toolchain
