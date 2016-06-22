DOGWEB_WORKDIR=~/datadog/dogweb
DEVOPS_WORKDIR=~/datadog/devops
AGENT_WORKDIR=~/datadog/dd-agent
PCHEF_WORKDIR=~/datadog/personal-chef

DDSSHKEY=~/.ssh/personal-chef

alias godogweb="cd $DOGWEB_WORKDIR"
alias goagent="cd $AGENT_WORKDIR"
alias godevops="cd $DEVOPS_WORKDIR"

alias startvm="cd $PCHEF_WORKDIR && vagrant up && cd -"
alias haltvm="cd $PCHEF_WORKDIR && vagrant halt && cd -"
alias sshvm="cd $PCHEF_WORKDIR && vagrant ssh && cd -"

function hotfixtime {
    cd $DOGWEB_WORKDIR
    git fetch
    git checkout prod
    HOTFIXLINK="https://github.com/DataDog/dogweb/compare/$(git describe --abbrev=0 --tags)...prod"
    echo -n $HOTFIXLINK | pbcopy
    echo "$HOTFIXLINK copied to clipboard"
    open $HOTFIXLINK
    cd -
}

function devopstime {
    cd $DEVOPS_WORKDIR
    git fetch
    git checkout prod
    HOTFIXLINK="https://github.com/DataDog/devops/compare/$(git describe --abbrev=0 --tags)...prod"
    echo -n $HOTFIXLINK | pbcopy
    echo "$HOTFIXLINK copied to clipboard"
    open $HOTFIXLINK
    cd -
}

function raclette {
    export GOPATH=~/datadog/vm/go-raclette
    export PATH=$GOPATH/bin:$PATH
    cd $GOPATH/src/github.com/DataDog/raclette
}

function stdgo {
    export GOPATH=~/datadog/gopath
    mkdir -p $GOPATH
    export PATH=$GOPATH/bin:$PATH
    cd $GOPATH
    go get github.com/cespare/reflex
    go get github.com/golang/lint/golint
    go get github.com/nsf/gocode

    mkdir -p $GOPATH/src/github.com/LeoCavaille/
    cd $GOPATH/src/github.com/LeoCavaille/
    git clone git@github.com:LeoCavaille/git-api
}

export AWS_KEYPATH=datadog/awskey/leo
# usage s3key prod access | s3key prod secret
function s3key {
    pass $AWS_KEYPATH | grep $1:$2 | cut -d' ' -f2
}

function s3stg {
    s3cmd --access_key=$(s3key staging access) --secret_key=$(s3key staging secret) $@
}
function s3prod {
    s3cmd --access_key=$(s3key prod access) --secret_key=$(s3key prod secret) $@
}

function ddchromeproxy {
    if [[ $# -ne 3 ]]; then
        echo "usage: ddchromeproxy <prod/stg> <dest ip from jumpbox> <port to open locally>"
        return
    fi

    # kill previous tunneling sessions
    ssh $1 "ps aux | grep \$(whoami) | grep 'ssh -T -NL' | grep -v grep | awk '{ print \$2 }' | xargs --no-run-if-empty kill"

    ssh -D 8888 -T $1 ssh -T -NL 127.0.0.1:9999:127.0.0.1:$3 $2 &
    SSH_SESSION=$!
    echo "Opened SSH tunnel in PID $SSH_SESSION"
    echo "Opening chrome proxying through that"
    TMPCHROME=$TMPDIR/`mktemp -d "chrome.XXXXXXX"`
    open -W -a "Google Chrome" -n --args --proxy-server="socks://localhost:8888" --user-data-dir=$TMPCHROME --no-first-run http://localhost:9999
    kill $SSH_SESSION
    rm -rf $TMPCHROME
}
