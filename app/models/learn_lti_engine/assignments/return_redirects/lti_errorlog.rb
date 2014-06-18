module LearnLtiEngine
  module Assignments
    module ReturnRedirects
      class LtiErrorlog
        attr_accessor :assignment

        STEP_NAME = 'lti_errorlog'

        def initialize(assignment)
          @assignment = assignment
        end

        def post_params(options)
          step_data = assignment.step_data_for_step(STEP_NAME)
          step_data.data['is_redirected'] = false

          tc = assignment.tool_consumer(options[:key], options[:secret], options[:launch_url])

          launch_data = tc.generate_launch_data
          launch_data['launch_presentation_return_url'] = "#{@assignment.lti_launch_params['root_url']}r/#{step_data.uuid}"
          launch_data['hide_buttons'] = true

          launch_data
        end

        def validation_fields
          []
        end

        def validation(options)
          binding.pry
          if options[:lti_errorlog] == "The floor's on fire... see... *&* the chair."
            { status: 'completed', message: 'Great job!' }
          else
            {
                status: 'incorrect',
                message: 'Wrong! Click launch to try again'
            }
          end
        end

      end
    end
  end
end
