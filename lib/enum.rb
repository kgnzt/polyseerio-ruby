require 'helper'

module Polyseerio
  module Enum
    # Contains resource routes.
    module Resource
      ALERT       = 'alerts'.freeze
      CHANNEL     = 'channels'.freeze
      ENVIRONMENT = 'environments'.freeze
      EVENT       = 'events'.freeze
      EXPECTATION = 'expectations'.freeze
      INSTANCE    = 'instances'.freeze
      LOGIC_BLOCK = 'logic-blocks'.freeze
      MEMBER      = 'members'.freeze
      MESSAGE     = 'messages'.freeze
      SETTING     = 'settings'.freeze
      TASK        = 'tasks'.freeze
    end

    # Contains type constants for use with API calls.
    module Type
      Resource.constants.each do |key|
        value = Helper.resource_to_type Resource.const_get(key)

        const_set(key, value)
      end
    end

    module Determiner
      ONE  = 'one'.freeze
      SOME = 'some'.freeze
    end

    module Direction
      INBOUND  = 'inbound'.freeze
      OUTBOUND = 'outbound'.freeze
    end

    module Subtype
      LONG_RUNNING = 'long_running'.freeze
      PERIODIC     = 'periodic'.freeze
    end

    module Color
      BLUE   = 'blue'.freeze
      BROWN  = 'brown'.freeze
      GREEN  = 'green'.freeze
      ORANGE = 'orange'.freeze
      PURPLE = 'purple'.freeze
      RED    = 'red'.freeze
      TEAL   = 'teal'.freeze
      WHITE  = 'white'.freeze
      YELLOW = 'yellow'.freeze
      NONE   = nil
    end

    module Icon
      THUMBS_UP    = 'thumbs-up'.freeze
      CALENDAR     = 'calendar'.freeze
      SERVER       = 'server'.freeze
      SIGNAL       = 'wifi'.freeze
      GIT          = 'git'.freeze
      CODE         = 'code'.freeze
      CHECK        = 'check'.freeze
      ERROR        = 'exclamation-triangle'.freeze
      PENCIL       = 'pencil'.freeze
      CHAIN        = 'chain'.freeze
      CHAIN_BROKEN = 'chain-broken'.freeze
      NONE         = nil
    end

    module Protocol
      SMTP = 'smtp'.freeze
      SMS  = 'sms'.freeze
    end

    module Strategy
      FALLBACK = :fallback
      ID       = :id
    end
  end
end
