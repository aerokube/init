// Micro init process to run zero downtime servers within containers
package main

import (
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"os/signal"
	"syscall"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Printf("Usage:\n\t%s COMMAND [args...]\n", os.Args[0])
		os.Exit(1)
	}
	cmd := exec.Command(os.Args[1], os.Args[2:]...)
	cmd.SysProcAttr = &syscall.SysProcAttr{Setpgid: true}
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		log.Fatal(err)
	}
	stderr, err := cmd.StderrPipe()
	if err != nil {
		log.Fatal(err)
	}
	err = cmd.Start()
	if err != nil {
		log.Fatal(err)
	}
	child, err := syscall.Getpgid(cmd.Process.Pid)
	if err != nil {
		log.Fatal(err)
	}

	go io.Copy(os.Stdout, stdout)
	go io.Copy(os.Stderr, stderr)

	sig := make(chan os.Signal)
	signal.Notify(sig)
	signal.Ignore(syscall.SIGCHLD)
	go func() {
		for {
			syscall.Kill(-(child), (<-sig).(syscall.Signal))
		}
	}()
	var status syscall.WaitStatus
	syscall.Wait4(-1, &status, 0, nil)
}
