#!/bin/bash

env=$1
branch=$2

repo="kkato1030/test-deployments"
deployments_endpoint_url="https://api.github.com/repos/${repo}/deployments"
service_domain="example.com"

function list_deployments () {
  curl -s -X GET \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${TOKEN}"      \
    -H "X-GitHub-Api-Version: 2022-11-28"    \
    $deployments_endpoint_url
}

function create_deployment () {
  local env=$1
  local branch=$2

  curl -s -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${TOKEN}"      \
    -H "X-GitHub-Api-Version: 2022-11-28"    \
    $deployments_endpoint_url                \
    -d '{"ref":"'$branch'","task":"'$env'-deploy","environment":"'$env'","auto_merge":false}' | jq -r '.statuses_url'
}

function create_deployment_status () {
  local statuses_url=$1

  curl -s -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${TOKEN}"      \
    -H "X-GitHub-Api-Version: 2022-11-28"    \
    $statuses_url \
    -d '{"state":"success","environment_url":"https://'${env}'.'${service_domain}'"}' >/dev/null
}

statuses_url=$(create_deployment $env $branch);
if echo "$statuses_url" | grep -q $deployments_endpoint_url; then
  create_deployment_status $statuses_url;
fi