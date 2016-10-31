module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    error_messages = []
    resource.errors.full_messages.each do |message|
      if message == "Team can't be blank"
        error_messages << "Must choose favorite team"
      elsif message != "Team must exist"
        error_messages << message
      end
    end

    if !resource.errors.messages[:team_id].empty?
      resource.errors.details.delete(:team_id)
      resource.errors.messages.delete(:team_id)
      resource.errors.messages[:team] = ["Must choose favorite team"]
    end

    messages = error_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end
