package main

import (
	"bytes"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/exec"
)

const (
	blogSitesFolderPath = "/opt/blog/sites"
	blogGitCheckoutPath = "/opt/blog/checkout"
	repoURL             = "git@github.com:webfrogs/blog.git"
)

func main() {
	http.HandleFunc("/", hookHandler)
	fmt.Println("Hook is working.")
	log.Fatal(http.ListenAndServe(":80", nil))
}

func hookHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		fmt.Println("Method not allowed")
		w.WriteHeader(http.StatusMethodNotAllowed)
		return
	}
	fmt.Println("receive a request.")

	if _, err := os.Stat(blogGitCheckoutPath); os.IsNotExist(err) {
		cloneShell := "git clone " + repoURL + " " + blogGitCheckoutPath
		err = runShell(cloneShell)
		if err != nil {
			fmt.Println(err)
			w.WriteHeader(http.StatusInternalServerError)
			return
		}
	} else {
		fetchShell := "cd " + blogGitCheckoutPath +
			" && git fetch origin master && git reset --hard origin/master"
		err := runShell(fetchShell)
		if err != nil {
			fmt.Println(err)
			w.WriteHeader(http.StatusInternalServerError)
			return
		}
	}

	blogBuildShell := "cd " + blogGitCheckoutPath + " && jekyll build"
	err := runShell(blogBuildShell)
	if err != nil {
		fmt.Println(err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	replaceSiteContentShell := "cd " + blogSitesFolderPath +
		" && rm -rf * && cp -r " + blogGitCheckoutPath + "/_site/* ."
	err = runShell(replaceSiteContentShell)
	if err != nil {
		fmt.Println(err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	fmt.Fprintln(w, "OK")
}

func runShell(s string) (err error) {
	cmd := exec.Command("/bin/sh", "-c", s)

	var out bytes.Buffer
	cmd.Stdout = &out
	err = cmd.Run()
	if err != nil {
		return
	}

	fmt.Println(out.String())
	return
}
