module EacCpfHelper
  module_function
  def to_eac_formatting field
    field = field.html_safe.gsub(/\n/, '</p><p>')
    field = '<p>' + field + '</p>'
    field.gsub!(/<p><\/p>/, '')
    field.gsub!(/<i>/, '<span style="font-style:italic">').gsub!(/<\/i>/, '</span>')
    field.gsub!(/<em>/, '<span style="font-style:italic">').gsub!(/<\/em>/, '</span>')
    field.gsub!(/<b>/, '<span style="font-weight:bold">').gsub!(/<\/b>/, '</span>')
  end
end
