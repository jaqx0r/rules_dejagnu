load("@rules_dejagnu//dejagnu:defs.bzl", "dejagnu_library", "dejagnu_test")

dejagnu_test(
    name = "simple_test",
    srcs = ["simple.exp"],
)

dejagnu_library(
    name = "lib",
    srcs = ["lib.exp"],
)

dejagnu_test(
    name = "lib_test",
    srcs = ["lib_test.exp"],
    deps = [":lib"],
)
