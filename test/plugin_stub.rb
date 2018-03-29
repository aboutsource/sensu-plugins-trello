# Copyright (c) 2015 Sensu-Plugins
#
# ported from https://github.com/sensu-plugins/sensu-plugins-process-checks/blob/38b4f532ec5366a8529300eb2dbea45880eee0cb/test/plugin_stub.rb
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

RSpec.configure do |c|
  c.before { allow($stdout).to receive(:puts) }
  c.before { allow($stderr).to receive(:puts) }

  # XXX: Sensu plugins run in the context of an at_exit handler. This prevents
  # XXX: code-under-test from being run at the end of the rspec suite.
  c.before(:each) do
    Sensu::Plugin::CLI.class_eval do
      # PluginStub
      class PluginStub
        def run; end

        def ok(*); end

        def warning(*); end

        def critical(*); end

        def unknown(*); end
      end
      class_variable_set(:@@autorun, PluginStub)
    end
  end
end
