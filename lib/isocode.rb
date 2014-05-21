require 'logger'
require 'open3'

# TODO support per-resource 'allow' DSL like rack-cors
# TODO support 'filter' DSL
module Rack
  class Isocode
    def initialize(app, opts={}, &block)
      @app = app
      @logger = opts[:logger]
      @debug_mode = !!opts[:debug]

      if block_given?
        if block.arity == 1
          block.call(self)
        else
          instance_eval(&block)
        end
      end
    end

    # TODO use this
    def driver(driver=nil, &block)
      if block_given?
        if block.arity == 1
          driver = block.call(self)
        else
          driver = instance_eval(&block)
        end
      end
      @driver = driver
    end

    def call(env)
      return @app.call env if bypass? env

      req = Rack::Request.new env
      ENV["PATH"] += ":/Users/jason/workspace/isocode/"
      stdin, stdout, stderr = Open3.popen3('isocode', '--', "#{req.scheme}://localhost:#{req.port}#{req.fullpath}")
      stdin.close
      body = stdout.read
      stderr.close
      stdout.close
      [200, {}, [body]]
    end

    protected

    def bypass?(env)
      req = Rack::Request.new env
      bypass_by_path?(req) || env['HTTP_X_ISOCODE'] == 'Bypass' || req.params["bypass-isocode"]
    end

    # TODO expose as configuration
    # TODO how to ask Rails for the asset prefix?
    def bypass_by_path?(req)
      req.path =~ /^\/assets/
    end
  end
end
