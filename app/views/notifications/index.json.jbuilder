json.array! @notifications do |notification|
  # json.recipient notification.recipient
  json.actor notification.actor.name
  json.action notification.action.humanize(capitalize: false)
  json.notifiable do #notification.notifiable
    json.type "an #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
  end
  json.url opportunity_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end
