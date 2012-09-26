module ApplicationHelper
  def method_missing(meth, *arg)
    if meth.to_s =~ /^(user|board|topic)_(.+)$/
      eval "#{$1.capitalize}.find(#{arg.first}).#{$2}"
    else
      super
    end
  end

  def respond_to?(meth)
    if meth.to_s =~ /^(user|board|topic)_.+$/
      true
    else
      super
    end
  end

  def title
    if current_page?(root_url) or current_page?(boards_url)
      app_name
    else
      @title = controller_name.humanize.singularize if @title.nil?
      action = "#{action_name.humanize} " unless %w[show index].include?(action_name)
      "#{app_name} | #{action}#{@title}"
    end
  end

  def app_name
    Rails.application.class.to_s.split("::").first
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def devise_error_messages
    return nil if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h4>#{sentence}</h4>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
