#!/bin/sh

# Before we start we need to make sure that chain and ipset are ready otherwise this script will not work.

chain_name="tunnel"
ipset_name="china_ip"
route_table="tunnel"
mark_tag=0xff