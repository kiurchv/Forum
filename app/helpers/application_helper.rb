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
      <p>#{sentence}</p>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
