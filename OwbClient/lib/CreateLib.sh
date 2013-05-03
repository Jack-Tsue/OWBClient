#!/bin/bash
#########################################################################
# File Name: CreateLib.sh
# Author: tsgsz
# mail: cdtsgsz@gmail.com
# Created Time: Mon Apr 29 18:03:44 2013
#Copyright [2013] <Copyright tsgsz>  [legal/copyright]
#########################################################################

lipo -create libOwbClientl* -output libOwbClient.a
