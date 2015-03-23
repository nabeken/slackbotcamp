#!/bin/bash
WORKSPACE="${WORKSPACE:-$(git rev-parse --show-toplevel)}"

cd "${WORKSPACE}/tf/"

if [ "${1}" = "apply" ]; then
  terraform "${@}" \
    -var "do_token=${DO_TOKEN}" \
    -var "do_domain=${DO_DOMAIN}" \
    -var "do_ssh_key=${DO_SSH_KEY}" \
    -state-out="terraform.tfstate.new"

  diff -u <(terraform show) <(terraform show terraform.tfstate.new) > /dev/null
  if [ $? -eq 1 ]; then
    cp terraform.tfstate{.new,}
    git add "${WORKSPACE}/tf/terraform.tfstate"
    git commit -m "tf: Updated by terraform [ci skip]"
    git push origin HEAD:${CIRCLE_BRANCH}
  fi
else
  terraform "${@}"
fi
