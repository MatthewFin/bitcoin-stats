# auto setup statsd with default config if /opt/statsd is missing
# needed for the use case when a docker host volume is mounted at an of the following:
#  - /opt/statsd
statsd_dir_contents=$(find /opt/statsd -mindepth 1 -print -quit)
if [[ -z $statsd_dir_contents ]]; then
  git clone -b v0.8.0 https://github.com/etsy/statsd.git /opt/statsd
  cp $conf_dir/opt/statsd/config_*.js /opt/statsd/
fi
