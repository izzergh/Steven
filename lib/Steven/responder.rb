module Steven
  class Responder
    def self.call(event, action, responses)
      author_id = event.author.id

      user = USER_LIST.find_user_by_id(author_id)

      if user
        if user.action_exists?(action)
          user.increment(:affirm)

          if user.trigger_affirmation?
            user.reset_action(action)
            event.respond responses.sample
          end
        end
      end
    end
  end
end
