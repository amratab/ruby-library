module Urbanairship
  module Push
    module Pipeline
      def pipeline(name: nil, enabled: required('enabled'), outcome: required('outcome'),
                   immediate_trigger: nil, historical_trigger: nil, constraint: nil,
                   condition: nil
      )
        fail ArgumentError,
             'Enabled should be a boolean value' unless enabled == true or enabled == false
        payload = { "enabled" => enabled }
        payload['name'] = name unless name.nil?
        payload['outcome'] = outcome unless outcome.nil?
        payload['immediate_trigger'] = immediate_trigger unless immediate_trigger.nil?
        payload['historical_trigger'] = historical_trigger unless historical_trigger.nil?
        payload['constraint'] = constraint unless constraint.nil?
        payload['condition'] = condition unless condition.nil?
        payload
      end


      def outcome(push: required('push'), delay: nil)
        fail ArgumentError,
             'Push must be a push object' unless push.is_a? Urbanairship::Push::Push
        fail ArgumentError,
             "The push object must have an audience of 'triggered'" unless push.audience == 'triggered'
        payload = { 'push' => push.payload }
        payload['delay'] = delay unless delay.nil?
        payload
      end

      def constraint(pushes: required('pushes'), days: required('days'))
        fail ArgumentError,
             'Neither Pushes nor Days can be set to nil' if pushes.nil? or days.nil?
        {
            'rate' => {
                'pushes' => pushes,
                'days' => days
            }
        }
      end

      def immediate_trigger(type: required('type'), tag: nil)
        allowed_types = ['open_first', 'tag_added', 'tag_removed']
        fail ArgumentError,
             "Immediate triggers must be of type 'open_first'," +
                 " 'tag_added', or 'tag_removed'" unless allowed_types.member? type
        fail ArgumentError,
             "Immediate triggers of type 'tag_added' or 'tag_removed' " +
                 "must specify the tag_id" if tag.nil? and type != 'open_first'
        if type == 'open_first'
          payload = type
        else
          payload = { type => tag }
        end
        payload
      end

      def historical_trigger(type: required('type'), tag: nil)
        allowed_types = ['open', 'tag_added', 'tag_removed']
        fail ArgumentError,
             "Historical triggers must be of type 'open'," +
                 " 'tag_added', or 'tag_removed'" unless allowed_types.member? type
        fail ArgumentError,
             "Historical triggers of type 'tag_added' or 'tag_removed' " +
                 "must specify the tag_id" if tag.nil? and type != 'open'
        if type == 'open'
          payload = type
        else
          payload = { type => tag }
        end
        payload
      end

      def tag_condition(tag: required('tag'), negated: false)
        fail ArgumentError,
             'tag_name cannot be set to nil' if tag.nil?
        {
            'tag' => {
                'tag_name' => tag,
                'negated' => negated
            }
        }
      end

      def or(cond_array: required('cond_array'))
        fail ArgumentError,
             'cond_array must be an array' unless cond_array.is_a Array
        { 'or' => cond_array }
      end

      def and(cond_array: required('cond_array'))
        fail ArgumentError,
             'cond_array must be an array' unless cond_array.is_a Array
        { 'and' => cond_array }
      end
    end
  end
end