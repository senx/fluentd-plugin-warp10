# README #

Fluentd plugin used to push data on Warp 10. This plugin is type OutputBuffer (http://docs.fluentd.org/articles/plugin-development#writing-buffered-output-plugins).

### fluentd-plugin-warp10 ###

* fluent plugin to send metrics to Warp 10

### Install ###

* Clone files from git

* Then exec

```
td-agent-gem build fluent-plugin-warp10.gemspec 
td-agent-gem install fluent-plugin-warp10-0.0.1.gem 

```

* Modify fluent config file (/etc/td-agent/td-agent.conf)

```
<match **>
   type warp10
   warpUri uri
   token token
   className fluentd
   flush_interval 60
</match>

```
Word ** corresponds to the fluentd tag you want to match. When there is a match fluentd will use this output to send values of all tags to Warp 10. warpUri is the uri to reach your Warp 10 instance. You have to put a write token and set a class name wich will prefix your Geo Time Series names. Flush interval corresponds to the time in seconds between two posts.

* Reload fluentd

### Contact ###

* contact@senx.io
