#!/bin/bash
WORKSPACE="${WORKSPACE:-$(git rev-parse --show-toplevel)}"

die() {
  echo "${@}" >&2
  exit 1
}

myterraform() {
  terraform "${@}" \
    -var "do_token=${DO_TOKEN}" \
    -var "do_domain=${DO_DOMAIN}" \
    -var "do_ssh_key=${DO_SSH_KEY}"
}

cd "${WORKSPACE}/tf/"

if [ "${1}" = "apply" ]; then
  myterraform "${@}" -state-out="terraform.tfstate.new" || die "failed to execute terraform"

  diff -u <(terraform show) <(terraform show terraform.tfstate.new) > /dev/null
  if [ $? -eq 1 ]; then
    cp terraform.tfstate{.new,}
    git add "${WORKSPACE}/tf/terraform.tfstate"
    git commit -m "tf: Updated by terraform [ci skip]"
    git push origin HEAD:${CIRCLE_BRANCH}
  fi
else
  myterraform "${@}" || die "failed to execute terraform"
fi
