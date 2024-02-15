#/usr/bin/env bash
# -*- mode: sh; -*-
#
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
#
# bazel requires an intermediate test executable per test rule, this template provides that executable.

export DEJAGNULIBS="{libdir}"

{runtest} --version

set -e

cat >site.exp <<EOF
set tool {tool}
set srcdir {srcdir}
set objdir `pwd`
EOF

# TODO: can bazel pass on debug level flags to this test runner?  If so we can modify --debug and -v -v per the runtest manual

{runtest} \
  --global_init `pwd`/site.exp \
  --status \
  --all \
  --debug \
  -v -v \
  --tool {tool} \
  --srcdir {srcdir} \
  --outdir $TEST_UNDECLARED_OUTPUTS_DIR \
  {srcs}
