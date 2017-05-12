#!/bin/bash

set -e

###
### Define vars
###
username=dcosson
github_org=finventures
github_repo="fin-core-beta"
github_repo_base="https://api.github.com/repos/${github_org}/${github_repo}"
created_in_past_num_hours=48
sleep_interval_seconds=300
past_timestamp_utc="$(ruby -e 'puts (Time.now.utc - (60*60*'"$created_in_past_num_hours"')).strftime("%Y-%m-%dT%H:%M:%S")')"

# parse 'hub' library for api token
yaml_file_as_json() { ruby -e 'require "yaml"; require "json"; puts JSON.dump(YAML.parse(open(File.expand_path("'"$1"'")).read).to_ruby)'; }
oauth_token="$(yaml_file_as_json "~/.config/hub" | jq -r '.["github.com"][0].oauth_token')"

###
### Check for PR's I should review
###
# Function to check if I should review a given PR (by number)
is_pr_for_me() {
    _username="$1"
    _oauth_token="$2"
    _github_repo_base="$3"
    _pr_number="$4"
    _pr_body="$(curl -s -H "Authorization: token $_oauth_token" "${_github_repo_base}/pulls/${_pr_number}")"
    _is_assigned_me="$(echo "$_pr_body" \
        | jq '.assignees | map(select(.login == "'"$_username"'")) | length > 0')"
    test -z $_is_assigned_me && (echo "ERROR No _is_assigned_me found" && exit 1)
    _is_merged="$(echo "$_pr_body" | jq '.merged')"
    test -z $_is_merged && (echo "ERROR No _is_merged found" && exit 1)
    _requested_reviewers_body="$(curl -s \
        -H "Authorization: token $_oauth_token" \
        -H 'Accept: application/vnd.github.black-cat-preview+json' \
        "${_github_repo_base}/pulls/${_pr_number}/requested_reviewers")"
    _is_requesting_me="$(echo "$_requested_reviewers_body" \
        | jq 'map(select(.login == "'"$_username"'")) | length > 0')"
    test -z $_is_requesting_me && (echo "ERROR No _is_requesting_me found" && exit 1)
    _reviews_body="$(curl -s \
        -H "Authorization: token $_oauth_token" \
        -H 'Accept: application/vnd.github.black-cat-preview+json' \
        "${_github_repo_base}/pulls/${_pr_number}/reviews")"
    _i_already_reviewed="$(echo "$_reviews_body" \
        | jq 'map(select(.user.login == "'"$_username"'")) | length > 0')"

    if [ "$_is_merged" == "false" ] && \
        ( [ "$_is_assigned_me" == "true" ] || [ "$_is_requesting_me" == "true" ] ) && \
        [ "$_i_already_reviewed" == "false" ]; then
        _for_me=true
        echo "$_pr_number"
    else
        _for_me=false
        echo ""
    fi
    # Debugging output
    # echo "PR $_pr_number merged: $_is_merged assigned: $_is_assigned_me requesting: "\
    #     "$_is_requesting_me already reviewed $_i_already_reviewed. Is for me: $_for_me" >&2
}
export -f is_pr_for_me

blink_the_light() {
    existing_color="$(blink1-tool --rgbread | awk '{print $5}')"
    blinking_color="0088ff"
    blink1-tool --rgb "$blinking_color" --blink 12
    blink1-tool --rgb "$existing_color"
}

array_contains() {
    local ref=$1[@]
    local item="$2"
    for val in "${!ref}"; do
        if [ "$val" == "${item}" ]; then
            return 0
        fi
    done
    return 1
}

prs_known_about=()

check_prs() {
    recent_open_prs=($(curl -s -H "Authorization: token $oauth_token" "${github_repo_base}/pulls?state=open"\
        | jq -r 'map(select(.updated_at > "'"$past_timestamp_utc"'")) | map(.number|tostring) | join(" ")'))

    # In parallel, check all open PR's if I should review them
    prs_to_review=($(parallel -j8 is_pr_for_me "$username" "$oauth_token" "$github_repo_base" ::: "${recent_open_prs[@]}"))

    # Output results
    if [ "${#prs_to_review[@]}" -gt 0 ]; then
        # blink the light whether or not we know about these PR, just don't print the output
        # multiple times if we already know about them.
        blink_the_light > /dev/null &
        echo ""
        echo "Checking $(date "+%Y-%m-%d %H:%M:%S")"
        for pr_number in "${prs_to_review[@]}"; do
            if array_contains prs_known_about "$pr_number"; then
                printf -v safe_item '%q' "$pr_number"
                eval "prs_known_about+=( $safe_item )"
            else
            echo "https://github.com/${github_org}/${github_repo}/pull/${pr_number}"
            fi
        done
        echo ""
        # debuggin
        # echo "prs known about ${prs_known_about[@]}"
    fi
}

run_repeatedly() {
    while true; do
        check_prs
        sleep "$sleep_interval_seconds"
    done
}

run_repeatedly
