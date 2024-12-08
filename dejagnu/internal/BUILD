load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

bzl_library(
    name = "versions",
    srcs = ["versions.bzl"],
    visibility = ["//:__subpackages__"],
)

bzl_library(
    name = "toolchain_info",
    srcs = ["toolchain_info.bzl"],
    visibility = ["//:__subpackages__"],
    deps = ["//dejagnu:providers"],
)

bzl_library(
    name = "toolchain_type",
    srcs = ["toolchain_type.bzl"],
    visibility = ["//:__subpackages__"],
)

bzl_library(
    name = "toolchain_repository",
    srcs = ["toolchain_repository.bzl"],
    visibility = ["//:__subpackages__"],
)

exports_files(
    [
        "dejagnu_runtest_wrapper.tpl",
    ],
    visibility = ["//visibility:public"],
)
