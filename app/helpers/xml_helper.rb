module XmlHelper
# hmm... and here lies madness! Should probably retire this helper.
# It is currently being used by oai_helper and unapi controller
def xml_processing_instruction
 '<?xml version="1.0" encoding="UTF-8"?>'
end

def open_xml_tag name, attributes=nil
  tag = "<" + name
  if attributes
    attributes = attributes.collect {|arry| arry.join('="') + '"'}
    tag += " " + attributes.join(" ")
  end
  tag += ">"
end

def close_xml_tag name
  "</#{name}>"
end

def make_xml_element name, content, attributes=nil
  element = open_xml_tag(name, attributes)
  if content
    element += content
    element += close_xml_tag(name)
  else
    element.gsub!(/>/, "/>")
  end
  element
end
end
