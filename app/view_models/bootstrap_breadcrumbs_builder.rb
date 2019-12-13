# The BootstrapBreadcrumbsBuilder is a Bootstrap compatible breadcrumb builder.
# It provides basic functionalities to render a breadcrumb navigation according to Bootstrap 4's conventions.
#
# You can use it with the :builder option on render_breadcrumbs:
#     <%= render_breadcrumbs builder: ::BootstrapBreadcrumbsBuilder %>
#
# Note: You may need to adjust the autoload_paths in your config/application.rb file for rails to load this class:
#     config.autoload_paths += %W(#{config.root}/lib)
#
class BootstrapBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
    def render
      @context.content_tag(:ul, class: 'breadcrumb') do
        @elements.collect do |element|
          render_element(element)
        end.join.html_safe
      end
    end
  
    def render_element(element)
      current = @context.current_page?(compute_path(element))
  
      @context.content_tag(:li, class: "breadcrumb-item #{'active' if current}") do
        @context.link_to_unless_current(compute_name(element), compute_path(element), element.options)
      end
    end
  end