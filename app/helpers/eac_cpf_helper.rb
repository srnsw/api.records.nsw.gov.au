module EacCpfHelper
  module_function
  def to_eac_formatting field
    field = '<p>' + field + '</p>'
    field.gsub!(/\n/, '</p><p>')
    field.gsub!(/<br\s*\/?>/, '</p><p>')  
    field.gsub!(/&nbsp;/, ' ')
    field.gsub!(/&(middot|ndash|emdash);/, '-')
    field.gsub!(/&quot;/, '"')
    field.gsub!(/&hellip;/, '...')
    field.gsub!(/&[lr][sd]quo;/, "'")
    field.gsub!(/<p>\s*<\/p>/, '')
    field.gsub!(/<\/?(?!(em|[\/pbi])).*?>/, '') # ... HErE bE DRAgONs [should strip any html except - p, em, b, i tags. Maybe requiring nokogiri/loofah would be saner!]
    field.gsub!(/<i>/, '<span style="font-style:italic">')
    field.gsub!(/<\/i>/, '</span>')
    field.gsub!(/<em>/, '<span style="font-style:italic">')
    field.gsub!(/<\/em>/, '</span>')
    field.gsub!(/<b>/, '<span style="font-weight:bold">')
    field.gsub!(/<\/b>/, '</span>')
    field.gsub!(/&(?!amp;)/, '&amp;')
    field.html_safe
  end
end
