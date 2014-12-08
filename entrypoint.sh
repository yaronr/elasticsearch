#!/bin/bash

echo "Taking a nap, to allow weave network to properly set up.."
sleep 20

echo "That was a good nap. Now to work..."
/elasticsearch/bin/elasticsearch "$@"
