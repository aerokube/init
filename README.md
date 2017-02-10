# Micro init

It runs within container as process with pid 1, translates received signals to child processes and wait until all of them exit.

Usage:

```init COMMAND [args...]

Useful to run servers like [this](https://github.com/facebookgo/grace) within containers.
