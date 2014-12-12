require 'cuba'
require 'cuba/render'
require 'mote'

# register mote on tilt
module Tilt
  class MoteTemplate < Template
    include Mote::Helpers

    def prepare; end

    def evaluate(scope, locals = {}, &block)
      template = Mote.parse(data, scope, locals.keys)
      template.call(locals)
    end
  end

  register(MoteTemplate, 'mote')
end

# cuba plugins
Cuba.plugin Cuba::Render

# set template engine to mote
Cuba.settings[:render][:template_engine] = "mote"

# cuba app
Cuba.define do
  on default do
    render("dashboard")
  end
end