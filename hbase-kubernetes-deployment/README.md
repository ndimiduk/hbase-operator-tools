# HBase Kubernetes Deployment

This module contains Kubernetes configurations suitable for deploying ZooKeeper, HDFS, and HBase.
It supports several physical topologies, including:
 * a minimum deployment footprint consisting of a single instance of each architectural component.
 * a high-avaiability deployment footprint consisting of redundancies for each architectural
   component.
 * a deployment where HBase region servers and HDFS data nodes share a pod, enabling short-circuit
   read between them.

## Usage

Deploying HBase or its dependencies from this repository requires Kustomize, either as a
stand-alone application or embedded in `kubectl`.

## Development

