<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Exported rules for DejaGNU bazel rules, the main library to include in user BUILD files.

<a id="dejagnu_library"></a>

## dejagnu_library

<pre>
load("@rules_dejagnu//dejagnu:defs.bzl", "dejagnu_library")

dejagnu_library(<a href="#dejagnu_library-name">name</a>, <a href="#dejagnu_library-deps">deps</a>, <a href="#dejagnu_library-srcs">srcs</a>)
</pre>

A DejaGNU Library.

This rule specifies `expect` program text that can be reused between testsuites.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="dejagnu_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="dejagnu_library-deps"></a>deps |  DejaGNU libraries used by this library.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="dejagnu_library-srcs"></a>srcs |  Program source files for this library.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |


<a id="dejagnu_test"></a>

## dejagnu_test

<pre>
load("@rules_dejagnu//dejagnu:defs.bzl", "dejagnu_test")

dejagnu_test(<a href="#dejagnu_test-name">name</a>, <a href="#dejagnu_test-deps">deps</a>, <a href="#dejagnu_test-srcs">srcs</a>, <a href="#dejagnu_test-data">data</a>, <a href="#dejagnu_test-tool_exec">tool_exec</a>)
</pre>

Run DejaGNU's `runtest` against a test suite.

See also https://www.gnu.org/software/dejagnu/manual/Invoking-runtest.html

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="dejagnu_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="dejagnu_test-deps"></a>deps |  DejaGNU libraries used by these testsuites.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="dejagnu_test-srcs"></a>srcs |  Testsuite files to execute.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="dejagnu_test-data"></a>data |  Extra data used by testsuites (e.g. input files, golden output files.)   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="dejagnu_test-tool_exec"></a>tool_exec |  Binary target under test.  If specified the executable is made available top the testsuite.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |


