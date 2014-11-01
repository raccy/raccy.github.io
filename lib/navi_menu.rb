require "yaml"

class NaviMenu < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end

  helpers do
    def lang_navi_menu(resource)
      if resource.data.hidden
        return ""
      end
      html = ""
      if resource == current_resource
        html << "<li class=\"active\">"
      else
        html << "<li>"
      end
      html << link_to(resource.data.title, resource.url)
      if ! resource.children.empty?
        html << "<ul class=\"nav nav-pills nav-stacked\" role=\"tablist\">"
        resource.children.each do |child|
          html << lang_navi_menu(child)
        end
        html << "</ul>"
      end
      html << "</li>"
      return html
    end
  end
end

::Middleman::Extensions.register(:navi_menu, NaviMenu)
