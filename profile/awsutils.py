#!/usr/bin/env python

import boto3

client = boto3.client('emr')

cluster_list = client.list_clusters()

print(cluster_list)
