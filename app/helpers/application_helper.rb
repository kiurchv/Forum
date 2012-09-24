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
end
