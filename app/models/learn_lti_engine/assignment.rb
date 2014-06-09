module LearnLtiEngine
  class Assignment < ActiveRecord::Base
    belongs_to :user
    serialize :lti_launch_params, Hash
    serialize :completed_tasks, Array

    ASSIGNMENTS = {
      "post_params" => {
        "title" => "LTI Activity 1. POST Parameters",
        "description" => "At their simplest level LTI launches are just POST requests. There are some standard parameters that you should expect to come across on all launches, and also some option parameters you'll potentially want to look for. Let's make sure you can retrieve these correctly.",
        "tasks" => %w( lti_message_type lti_version resource_link_id context_id user_id roles oauth_consumer_key oauth_nonce oauth_timestamp oauth_signature lis_person_full_name custom_params lis_outcome_service_url )
      },
      "signature_verification" => {
        "title" => "LTI Activity 2. Signature Verification",
        "description" => "Make sure you know how to verify signatures and other security parameters.",
        "tasks" => %w( lti_message_type lti_version resource_link_id context_id user_id roles oauth_consumer_key oauth_nonce oauth_timestamp oauth_signature lis_person_full_name custom_params lis_outcome_service_url )
      },
      "return_redirects" => {
        "title" => "LTI Activity 3. Return Redirects",
        "description" => "Make sure you know how to redirect back to the LMS, potentially with success or error messages.",
        "tasks" => %w( lti_message_type lti_version resource_link_id context_id user_id roles oauth_consumer_key oauth_nonce oauth_timestamp oauth_signature lis_person_full_name custom_params lis_outcome_service_url )
      },
      "xml_configuration" => {
        "title" => "LTI Activity 4. XML Configuration",
        "description" => "Make sure you know how to <a href=\"https://lti-examples.heroku.com/build_xml.html\">build config XML</a>.",
        "tasks" => %w( lti_message_type lti_version resource_link_id context_id user_id roles oauth_consumer_key oauth_nonce oauth_timestamp oauth_signature lis_person_full_name custom_params lis_outcome_service_url )
      },
      "returning_content" => {
        "title" => "LTI Activity 5. Returning Content",
        "description" => "Make sure you know how to use <a href=\"https://canvas.instructure.com/doc/api/file.tools_intro.html\">the content extensions in Canvas</a> to return resources.",
        "tasks" => %w( lti_message_type lti_version resource_link_id context_id user_id roles oauth_consumer_key oauth_nonce oauth_timestamp oauth_signature lis_person_full_name custom_params lis_outcome_service_url )
      },
      "grade_passback" => {
        "title" => "LTI Activity 6. Grade Passback",
        "description" => "Make sure you know how to pass grades back to the learning platform.",
        "tasks" => %w( lti_message_type lti_version resource_link_id context_id user_id roles oauth_consumer_key oauth_nonce oauth_timestamp oauth_signature lis_person_full_name custom_params lis_outcome_service_url )
      }
    }

    validates :user_id, presence: true
    validates :lti_assignment_id, presence: true, uniqueness: true
    validates :name, presence: true, inclusion: { in: ASSIGNMENTS.keys }

    def is_completed?
      (completed_tasks & ASSIGNMENTS[name]["tasks"]).length == ASSIGNMENTS[name]["tasks"].length
    end

    def as_json
      {
          id: id,
          name: name,
          lti_user_id: user.lti_user_id,
          lti_assignment_id: lti_assignment_id,
          completed_tasks: completed_tasks,
          is_completed: self.is_completed?
      }
    end
  end
end