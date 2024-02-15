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

"""Module extension definition for DejaGNU.

This contains the `load`able extension for a bzlmod `MODULE.bazel` file.
"""

load("//dejagnu/internal:repository.bzl", "dejagnu_repository")
load("//dejagnu/internal:toolchain_repository.bzl", "dejagnu_toolchain_repository")
load("//dejagnu/internal:versions.bzl", "DEFAULT_VERSION", "VERSION_URLS")

def _repo_name(version):
    return "dejagnu_v{}".format(version)

def _dejagnu_repository_ext(module_ctx):
    root_direct_deps = []
    root_direct_dev_deps = []
    dejagnu_repo_names = {}

    for module in module_ctx.modules:
        for config in module.tags.toolchain:
            name = config.name
            if not name:
                name = "dejagnu"

            repo_name = _repo_name(config.version)

            dejagnu_toolchain_repository(
                name = name,
                dejagnu_repository = "@" + repo_name,
            )

            if module.is_root:
                if module_ctx.is_dev_dependency(config):
                    root_direct_dev_deps.append(name)
                else:
                    root_direct_deps.append(name)

            if repo_name not in dejagnu_repo_names:
                dejagnu_repo_names[repo_name] = True
                dejagnu_repository(
                    name = repo_name,
                    version = config.version,
                )

    return module_ctx.extension_metadata(
        root_module_direct_deps = root_direct_deps,
        root_module_direct_dev_deps = root_direct_dev_deps,
    )

_REPOSITORY_TAG_ATTRS = {
    "name": attr.string(doc = """An optional name for this repository, if in the root module.

If unset, the repository name will default to `dejagnu_v{version}`.
"""),
    "version": attr.string(doc = "A supported version of DejaGNU.", mandatory = True, default = DEFAULT_VERSION, values = sorted(VERSION_URLS)),
}

dejagnu = module_extension(
    implementation = _dejagnu_repository_ext,
    tag_classes = {
        "toolchain": tag_class(
            attrs = _REPOSITORY_TAG_ATTRS,
        ),
    },
    doc = """\
    Module extension for declaring dependencies on DejaGNU.

    ### Example `MODULE.bazel`

    ```starlark
    dejagnu = use_extension("@rules_dejagnu//dejagnu:extension.bzl", "dejagnu")

    dejagnu.toolchain(version = "1.6.3")
    use_repo(dejagnu, "dejagnu")

    register_toolchains("@dejagnu//:toolchain")
    ```
    """,
)
