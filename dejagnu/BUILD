load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

exports_files(["defs.bzl"])

toolchain_type(
    name = "toolchain_type",
    visibility = ["//visibility:public"],
)

bzl_library(
    name = "defs",
    srcs = ["defs.bzl"],
    visibility = ["//visibility:public"],
    deps = [
        "//dejagnu/rules:dejagnu",
        "//dejagnu/rules:dejagnu_library",
    ],
)

bzl_library(
    name = "extension",
    srcs = ["extension.bzl"],
    visibility = ["//visibility:public"],
)

bzl_library(
    name = "providers",
    srcs = ["providers.bzl"],
    visibility = ["//visibility:public"],
)
