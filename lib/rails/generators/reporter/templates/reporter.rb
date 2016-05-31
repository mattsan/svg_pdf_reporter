<% module_namespacing do -%>
class <%= class_name %>Reporter < ApplicationReporter
<% actions.each do |action| -%>
  def <%= action %>
  end
<% end -%>
end
<% end -%>
