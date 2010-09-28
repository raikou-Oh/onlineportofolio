# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def add_link(text, param, partial_file, obj )
    button_to_function text do |page|
      page.insert_html :bottom, 
        param, 
        :partial => partial_file , 
        :object => obj
    end
  end
  
  def style_tag(isi)
    @template.content_tag("style",isi,:type => "text/css")  
  end
  
  def div_tag(isi={},option={})
    @template.content_tag("div",isi,option)  
  end
  
  def span_tag(isi={},option={})
    @template.content_tag("span",isi,option)  
  end 
  
  
  def create_row_div(isi={},option={})
    option["class"] = "row"
    
    isi.map do |x|
      x.map do |index,item|
        unless item.to_s.empty?
         @template.content_tag("div", 
          div_tag(index,:class => "row_label" )+div_tag(item,:class => "row_content" ),
         option)
        end
      end
    end
  end
  
  def tr_tag(isi={},option={})
    @template.content_tag("tr",isi,option) 
  end
  def td_tag(isi={},option={})
    @template.content_tag("td",isi,option) 
  end
  
  def create_table_row(isi={},option={})
    option["class"] = "row"    
    isi.map do |x|
      x.map do |index,item|
        unless item.to_s.empty?
         content = ''
         if item.kind_of? Array
           item.collect {|i| content += td_tag(i.to_s).to_s }
         else
           content = td_tag(item.to_s)
         end
         @template.content_tag("tr", 
          td_tag(index, :width => "30%" )+content.to_s,
         option)
        end
      end
    end
  end
  

end
