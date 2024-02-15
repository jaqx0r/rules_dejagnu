load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

bzl_library(
    name = "dejagnu",
    srcs = ["dejagnu.bzl"],
    visibility = ["//:__subpackages__"],
    deps = [
        "//dejagnu:providers",
        "//dejagnu/internal:toolchain_type",
    ],
)

bzl_library(
    name = "dejagnu_library",
    srcs = ["dejagnu_library.bzl"],
    visibility = ["//:__subpackages__"],
    deps = ["//dejagnu:providers"],
)
