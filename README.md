# README #
Fluentd plugin used to push data on Warp10. This plugin is type OutputBuffer (http://docs.fluentd.org/articles/plugin-development#writing-buffered-output-plugins).

### fluentd-plugin-warp10 ###

* fluent plugin to send metrics to Warp10

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
Word ** correspond  to the fluentd tag you want to match. When there is a match fluentd will use this output to send values of all tags in Warp10. warpUri is the uri to reach on cityzendata.com. You have to put a write token and a set a class name wich will prefix your GTS name. Flush interval correspond to the time in second between two post.

* Reload fluentd

### Contact ###

* contact@cityzendata.com