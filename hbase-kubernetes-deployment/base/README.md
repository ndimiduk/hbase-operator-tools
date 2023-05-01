Some values such as SERVICE name, SERVICEACCOUNT name,
and RBAC role are hard-coded in the environment-configmap.yaml
and supplied into the pods as environment variables. Other
hardcodings include the service name ('hadoop') and the
namespace we run in (also 'hadoop').

The hadoop Configuration system can interpolate environment variables
into '\*.xml' file values ONLY.  See
[Configuration Javadoc](http://hadoop.apache.org/docs/current/api/org/apache/hadoop/conf/Configuration.html)

...but we can not do interpolation of SERVICE name into '\*.xml' file key names
as is needed when doing HA in hdfs-site.xml... so for now, we have
hard-codings in 'hdfs-site.xml' key names.  For example, the property key name
`dfs.ha.namenodes.hadoop` has the SERVICE name ('hadoop') in it or the key
`dfs.namenode.http-address.hadoop` (TODO: Fix/Workaround).

Edit of pod resources or jvm args for a process are
done in place in the yaml files or in kustomization
replacements in overlays.
