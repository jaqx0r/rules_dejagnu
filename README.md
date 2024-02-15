# Bazel build rules for DejaGNU test suites.

[DejaGNU](https://www.gnu.org/software/dejagnu/manual/index.html) is a
framework for testing other programs.  Based on Expect, it provides a mechanism
for interacting with those other programs to test for positive and negative
behaviours.

The full manual for DejaGNU is https://www.gnu.org/software/dejagnu/manual/index.html

This is a Bazel module (https://bazel.build) that provides a way to let Bazel execute DejaGNU test suites.

NOTE: This module assumes the existence of the `expect` interpreter in the system path.  It is future-work to offer a hermetic `expect` in the Bazel build environment.

## Setup

Add the following to your `MODULE.bazel`:

```
bazel_dep(name = "rules_dejagnu", version = "0.0.1", dev_dependency = True)
```


## Examples

```
load("@rules_dejagnu//dejagnu:defs.bzl", "dejagnu_test")

dejagnu_test(name = "simple", srcs = ["simple.exp"])
```

See [`testsuite/BUILD`](testsuite/BUILD) for working examples.
