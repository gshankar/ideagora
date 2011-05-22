module ApplicationHelper
  def flash_helper
    [:error, :warning, :notice, :message, :alert].collect do |key|
      content_tag(:p, flash[key], :class => key.to_s) unless flash[key].blank?
    end.join
  end
	
end
