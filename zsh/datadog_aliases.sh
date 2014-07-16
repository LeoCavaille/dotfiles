DOGWEB_WORKDIR=~/datadog/vm/dogweb
DEVOPS_WORKDIR=~/datadog/devops

# Jumpboxes
alias sshprod="mosh --ssh=\"ssh -i ~/.ssh/personal-chef\" leo@kerberos.datadoghq.com"
alias sshstg="mosh --ssh=\"ssh -i ~/.ssh/personal-chef\" leo@kerberos.datad0g.com"

function hotfixtime {
    cd $DOGWEB_WORKDIR
    HOTFIXLINK="https://github.com/DataDog/dogweb/compare/$(git describe --abbrev=0 --tags)...prod"
    echo -n $HOTFIXLINK | pbcopy
    echo "$HOTFIXLINK copied to clipboard"
    open $HOTFIXLINK
    cd -
}
