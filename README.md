# MicroInit

MicroInit is a small process to be run within Docker container as init process (with `pid 1`). It translates any received signals to child processes and waits until all of them exit.

Usage:

```
init COMMAND [args...]
```

Useful to run servers like [this](https://github.com/facebookgo/grace) within containers.
