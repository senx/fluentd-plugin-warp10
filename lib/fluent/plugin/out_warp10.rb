#
#   Copyright 2016  Cityzen Data
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http:#www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

module Fluent
  class Warp10Output < BufferedOutput
    Plugin.register_output('warp10', self)

    config_param :flush_interval, :time, :default => 60
    config_param :warpUri, :string, :default => "localhost:4242"
    config_param :token, :string, :default => 'token'
    config_param :className, :string, :default => 'fluentd'

    def initialize
      require 'net/http'
      require 'net/https'
      require 'uri'
      super
    end

    unless method_defined?(:log)
        define_method("log") { $log }
    end

    def configure(conf)
      super
      @warpUri = conf['warpUri']
      @token = conf['token']
      @className = conf['className']
      @flush_interval = conf['flush_interval']
    end

    def start
      super
    end

    def shutdown
      super
    end

    def format(tag, time, record)
      time = time * 1000000
      fluentString = String.new
      record.each {|key,value| 
	fix = String.new
        if value.is_a?(String)
          fix = "'"
        end
        fluentString += time.to_s + "// " + className.to_s + "." + tag.to_s + "{key=" + key.to_s + ",source=fluentd} " + fix + value.to_s + fix + "\n"
      }
      fluentString.to_msgpack
    end

    def write(chunk)
      collectString = String.new
      chunk.msgpack_each {|cur|
        collectString += cur
      }
    uri = URI.parse(warpUri)
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'X-Warp10-Token'=> token, 'Content-Type'=> 'text/plain'})
    req.body = collectString.encode("iso-8859-1").force_encoding("utf-8")
    res = https.request(req)
    log.info "Response #{res.code} #{res.message}: #{res.body}"
    end
  end
end
