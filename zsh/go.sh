alias gocover="go test -v -coverprofile=coverage.out && go tool cover -html=coverage.out"

export GOPROFILECOUNTER=0
alias gobench="export GOPROFILECOUNTER=\$((GOPROFILECOUNTER+1)); go test -bench=. -memprofile=prof.mem -cpuprofile=prof.cpu | tee prof.\$GOPROFILECOUNTER"
alias goalloc="go tool pprof --alloc_space *.test prof.mem"
alias gocpu="go tool pprof *.test prof.cpu"
alias gomem="go tool pprof --inuse_space *.test prof.mem"
