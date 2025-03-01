# Bazel build rules for DejaGNU test suites.

[DejaGNU](https://www.gnu.org/software/dejagnu/manual/index.html) is a
framework for testing other programs.  Based on Expect, it provides a mechanism
for interacting with those other programs to test for positive and negative
behaviours.

The full manual for DejaGNU is https://www.gnu.org/software/dejagnu/manual/index.html

This is a Bazel module (https://bazel.build) that provides a way to let Bazel execute DejaGNU test suites.

Full API documentation is available in [`docs/rules.md`](docs/rules.md)

NOTE: This module assumes the existence of the `expect` interpreter in the system path.  It is future-work to offer a hermetic `expect` in the Bazel build environment.

## Setup

Add the following to your `MODULE.bazel`:

```
bazel_dep(name = "rules_dejagnu", version = "0.0.1", dev_dependency = True)
git_override(
    module_name = "rules_dejagnu",
    commit = "8e57c675f9e3efa394588a87966b9e132216588c",
    remote = "https://github.com/jaqx0r/rules_dejagnu.git",
)
```


## Examples

```
load("@rules_dejagnu//dejagnu:defs.bzl", "dejagnu_test")

dejagnu_test(name = "simple", srcs = ["simple.exp"])
```

Full API documentation is available in [`docs/rules.md`](docs/rules.md). See [`testsuite/BUILD`](testsuite/BUILD) for working examples.


## Debugging

`bazel test --strategy=TestRunner=local //:simple_test` will leave the test tree lying around for inspection.
