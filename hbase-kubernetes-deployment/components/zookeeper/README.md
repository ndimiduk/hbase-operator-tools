Uses latest image from the apache zookeeper project.
There is then a start script in 'single-instance/start.sh'
which sets parameters for the zookeeper image and process
on startup. Currently only logs to STDOUT/STDERR; there
are no files in /var/log/zookeeper.
