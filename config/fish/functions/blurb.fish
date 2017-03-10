function blurb --description Post\ to\ 10C.\\nblurb\ post\ MESSAGE\\nblurb\ POST_ID\ REPLY --argument reply_id message
	set -l token $TEN_CENTURIES_API_TOKEN
set -l endpoint https://api.10centuries.org/content/write

set -l usage 'blurb: post or reply to a message on 10C

Usage:

  blurb post MESSAGE
  Post a new blurb
  Example: blurb post \'Hello, world!\'

  blurb POST_ID REPLY
  Reply to post POST_ID
  Example: blurb 1234 \'My reply to post 1234.\'

Environment variables:

  TEN_CENTURIES_AUTH_TOKEN
  Your auth token.

Author: Jeremy W. Sherman (@jws on 10C)
Date: 2017-03-10
Version: 1.0, Initial Release
License:
This Source Code Form is subject to the terms of the
Mozilla Public License, v. 2.0.
If a copy of the MPL was not distributed with this file,
You can obtain one at https://mozilla.org/MPL/2.0/.'

if not count $argv >/dev/null
    echo 'blurb: error: no message provided; did you mean: blurb post MESSAGE' >/dev/stderr
    echo $usage >/dev/stderr
    return 1
end

if contains -- $argv[1] -h --help '-?'
    echo $usage
    return 0
end

if test -z $token
    echo "blurb: error: API token not set: set -U TEN_CENTURIES_API_TOKEN <your token here>" >/dev/stderr
    return 1
end

set message (string replace '"' '\\\\"' $message)
set -l body '{"channel_guid": "", "content": "'$message'", "post_id": ""'
if test $reply_id != post
    set body $body', "reply_to": "'$reply_id'"'
end
set body $body'}'

curl \
    -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: $token" \
    $endpoint \
    --data $body | jq '.meta, (.data | map({id}))'
end
