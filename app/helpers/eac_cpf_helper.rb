module EacCpfHelper
  module_function
  def to_eac_formatting field
    field = '<p>' + field + '</p>'
    field.gsub!(/\n/, '</p><p>')
    field.gsub!(/<a.*?>/, '')
    field.gsub!(/<\/a>/, '')
    field.gsub!(/<br>/, '</p><p>')
    field.gsub!(/<br\s*\/>/, '</p><p>')  
    field.gsub!(/<p>\s*<\/p>/, '')
    field.gsub!(/<i>/, '<span style="font-style:italic">')
    field.gsub!(/<\/i>/, '</span>')
    field.gsub!(/<em>/, '<span style="font-style:italic">')
    field.gsub!(/<\/em>/, '</span>')
    field.gsub!(/<b>/, '<span style="font-weight:bold">')
    field.gsub!(/<\/b>/, '</span>')
    field.gsub!(/&/, '&amp;')
    field.html_safe
  end
end
