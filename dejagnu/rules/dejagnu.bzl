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

"""Dejagnu test runner."""

load("//dejagnu:providers.bzl", "DejaGNULibraryInfo")
load("//dejagnu/internal:toolchain_type.bzl", "DEJAGNU_TOOLCHAIN_TYPE", "dejagnu_toolchain")

def _dejagnu_test_impl(ctx):
    """Implementation of dejagnu test suite."""
    executable_path = "{name}_/{name}".format(name = ctx.label.name)
    executable = ctx.actions.declare_file(executable_path)

    dejagnu = dejagnu_toolchain(ctx)

    libdir = dejagnu.runtest.libs.to_list()[0].path

    substitutions = {
        "{tool}": ctx.label.name,
        "{srcdir}": ctx.files.srcs[0].dirname,
        "{runtest}": dejagnu.runtest.runtest.executable.path,
        "{libdir}": dejagnu.runtest.libs.to_list()[0].dirname,
        "{srcs}": " ".join([src.basename for src in ctx.files.srcs]),
    }

    ctx.actions.expand_template(
        template = ctx.file._runtest_template,
        output = executable,
        substitutions = substitutions,
        is_executable = True,
    )

    # gather runfiles
    files = [
        dejagnu.runtest.runtest.executable,
    ] + dejagnu.runtest.libs.to_list()
    if ctx.file.tool_exec:
        files.append(ctx.file.tool_exec)
    files.extend(ctx.files.srcs)
    files.extend(ctx.files.data)
    runfiles = ctx.runfiles(files = files)
    runfiles = runfiles.merge_all(
        [
            dep[DefaultInfo].default_runfiles
            for dep in ctx.attr.deps
        ],
    )

    test_env = {}

    # Are this rule's sources or any of the sources for its direct dependencies
    # in deps instrumented?
    if (ctx.configuration.coverage_enabled and
        (ctx.coverage_instrumented() or
         any([ctx.coverage_instrumented(dep) for dep in ctx.attr.deps]) or
         ctx.coverage_instrumented(ctx.attr.tool_exec))):
        # Bazel’s coverage runner
        # (https://github.com/bazelbuild/bazel/blob/6.4.0/tools/test/collect_coverage.sh)
        # needs a binary called “lcov_merge.”  Its location is passed in the
        # LCOV_MERGER environmental variable.  For builtin rules, this variable
        # is set automatically based on a magic “$lcov_merger” or
        # “:lcov_merger” attribute, but it’s not possible to create such
        # attributes in Starlark.  Therefore we specify the variable ourselves.
        # Note that the coverage runner runs in the runfiles root instead of
        # the execution root, therefore we use “path” instead of “short_path.”
        runfiles = runfiles.merge(
            ctx.attr._lcov_merger[DefaultInfo].default_runfiles,
        )
        test_env["LCOV_MERGER"] = ctx.executable._lcov_merger.path

        # C/C++ coverage instrumentation needs another binary that wraps gcov;
        # see
        # https://github.com/bazelbuild/bazel/blob/6.4.0/tools/test/collect_coverage.sh#L183.
        # This is normally set from a hidden “$collect_cc_coverage” attribute;
        # see
        # https://github.com/bazelbuild/bazel/blob/6.4.0/src/main/java/com/google/devtools/build/lib/analysis/test/TestActionBuilder.java#L256-L261.
        # We also need to inject its location here, like above.
        runfiles = runfiles.merge(
            ctx.attr._collect_cc_coverage[DefaultInfo].default_runfiles,
        )
        test_env["CC_CODE_COVERAGE_SCRIPT"] = ctx.executable._collect_cc_coverage.path

    return [
        DefaultInfo(
            runfiles = runfiles,
            executable = executable,
        ),
        testing.TestEnvironment(test_env),
        coverage_common.instrumented_files_info(
            ctx,
            source_attributes = ["srcs"],
            dependency_attributes = ["deps", "data", "tool_exec"],
        ),
    ]

dejagnu_test = rule(
    implementation = _dejagnu_test_impl,
    doc = """\
    Run DejaGNU's `runtest` against a test suite.

    See also https://www.gnu.org/software/dejagnu/manual/Invoking-runtest.html
    """,
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".exp"],
            doc = "Testsuite files to execute.",
        ),
        "deps": attr.label_list(providers = [DejaGNULibraryInfo], doc = "DejaGNU libraries used by these testsuites."),
        "data": attr.label_list(
            allow_files = True,
            doc = "Extra data used by testsuites (e.g. input files, golden output files.)",
        ),
        "tool_exec": attr.label(
            executable = True,
            doc = "Binary target under test.  If specified the executable is made available top the testsuite.",
            cfg = "target",
            allow_single_file = True,
        ),
        "_runtest_template": attr.label(
            default = "//dejagnu/internal:dejagnu_runtest_wrapper.tpl",
            allow_single_file = True,
        ),
        # Magic coverage attributes.  This is only partially documented
        # (https://bazel.build/rules/lib/coverage#output_generator), but we can
        # take over the values from
        # https://github.com/bazelbuild/bazel/blob/7.0.0-pre.20231018.3/src/main/starlark/builtins_bzl/common/python/py_test_bazel.bzl.
        "_lcov_merger": attr.label(
            default = configuration_field("coverage", "output_generator"),
            executable = True,
            cfg = "exec",
        ),
        "_collect_cc_coverage": attr.label(
            default = Label("@bazel_tools//tools/test:collect_cc_coverage"),
            executable = True,
            cfg = "exec",
        ),
    },
    toolchains = [DEJAGNU_TOOLCHAIN_TYPE],
    test = True,
)
