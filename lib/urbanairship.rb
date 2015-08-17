require 'urbanairship/push/audience'
require 'urbanairship/push/payload'
require 'urbanairship/push/schedule'
require 'urbanairship/push/push'
require 'urbanairship/client'
require 'urbanairship/common'
require 'urbanairship/loggable'
require 'urbanairship/util'
require 'urbanairship/version'
require 'urbanairship/devices/devicelist'
require 'urbanairship/devices/channel_tags'
require 'urbanairship/devices/named_user'
require 'urbanairship/reports/per_push'
require 'urbanairship/reports/response_statistics'
require 'urbanairship/devices/static_lists'
require 'urbanairship/push/pipeline'
require 'urbanairship/push/automation'

module Urbanairship
  extend Urbanairship::Push::Audience
  extend Urbanairship::Push::Payload
  extend Urbanairship::Push::Schedule
  extend Urbanairship::Push
  extend Urbanairship::Push::Pipeline
  include Urbanairship::Devices
  include Urbanairship::Reports
  include Urbanairship::Push
end
