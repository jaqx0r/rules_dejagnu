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

"""Repository rule for a specific version of DejaGNU."""

load("//dejagnu/internal:versions.bzl", "VERSION_URLS")

# Specifies the parts of the unpacked source code within DejaGNU that we need.
_DEJAGNU_BUILD = """\
# Generated by @rules_dejagnu/dejagnu/internal:repository.bzl

filegroup(
    name = "libs",
    srcs = ["runtest.exp", "config.guess"] + glob(["lib/*.exp", "config/*.exp"]),
    visibility = ["//visibility:public"]
)

exports_files(["runtest"])
"""

# Specifies the DejaGNUToolchainInfo based on the unpacked source.
_DEJAGNU_TOOLCHAIN_BUILD = """\
# Generated by @rules_dejagnu/dejagnu/internal:repository.bzl
load("@rules_dejagnu//dejagnu/internal:toolchain_info.bzl", "dejagnu_toolchain_info")

dejagnu_toolchain_info(
    name = "toolchain_info",
    runtest = "//:runtest",
    libs = "//:libs",
    visibility = ["//visibility:public"],
)
"""

def _dejagnu_repository_impl(repository_ctx):
    version = repository_ctx.attr.version
    source = VERSION_URLS[version]

    repository_ctx.download_and_extract(
        url = source["urls"],
        integrity = source["integrity"],
        stripPrefix = "dejagnu-{}".format(version),
    )
    repository_ctx.file(
        "MODULE.bazel",
        "module(name = {name})\n".format(name = repr(repository_ctx.name)),
    )
    repository_ctx.file("BUILD.bazel", _DEJAGNU_BUILD)
    repository_ctx.file("toolchain/BUILD.bazel", _DEJAGNU_TOOLCHAIN_BUILD)

dejagnu_repository = repository_rule(
    implementation = _dejagnu_repository_impl,
    doc = """\
    Repository rule for a specific DejaGNU version.

    This repository rule creates a repository that contains a
    DejaGNUToolchainInfo provider naming the `runtest` binary and the DejaGNU
    libraries it depends on, and makes it available for the main rules to use.
    """,
    attrs = {
        "version": attr.string(
            doc = "A supported version of DejaGNU.",
            mandatory = True,
            values = sorted(VERSION_URLS),
        ),
    },
)
