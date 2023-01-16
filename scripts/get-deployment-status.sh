#!/bin/bash

sha=$1

repo="kkato1030/test-deployments"
deployments_endpoint_url="https://api.github.com/repos/${repo}/deployments"
service_domain="example.com"

function get_deployment_status_by_sha () {
  local sha=$1

  statuses_url=$(curl -s -X GET \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${TOKEN}"      \
    -H "X-GitHub-Api-Version: 2022-11-28"    \
    "$deployments_endpoint_url?sha=$branch" | jq -r '.[0].statuses_url')
  curl -s -X GET \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${TOKEN}"      \
    -H "X-GitHub-Api-Version: 2022-11-28"    \
    "$statuses_url?per_page=1" | jq -r '.[0].state'
}

get_deployment_status_by_sha $sha