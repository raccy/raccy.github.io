class LangHelper < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end

  helpers do
    def lang_contents(list)
      html = ""
      html << "<ul>"
      list.each do |key, value|
        html << "<li>"
        if value["path"]
          html << link_to(value["name"],
              File.join(http_prefix, value["path"]),
              class: "btn btn-default btn-xs",
              role: "button")
        else
          html << link_to(value["name"],
              "\#",
              class: "btn btn-default btn-xs disabled",
              role: "button")
        end
        if value["desc"]
          html << " ・・・ " << escape_html(value["desc"])
        end
        if value["children"]
          html << lang_contents(value["children"])
        end
        html << "</li>"
      end
      html << "</ul>"
      return html
    end

    def lang_table(head, list)
      note_list = []
      html = ""
      html << "<div class=\"table-responsive\">"
      html << "<table class=\"table table-bordered table-condensed small\">"
      # ヘッド
      html << "<thead>"
      html << "<tr>"
      html << "<th>言語</th>"
      head.each do |head_val|
        html << "<th>#{head_val['title']}</th>"
      end
      html << "</tr>"
      html << "</thead>"
      # ボディ
      html << "<tbody>"
      list.each do |lang, val_list|
        next if lang == "_head"
        if val_list.is_a?(Array)
          first_val = true
          val_list.each do |val|
            html << "<tr>"
            if first_val
              # 言語名は1度だけ
              html << "<td rowspan=\"#{val_list.size}\">"
              html << escape_html(lang)
              html << "</td>"
              first_val = false
            end
            #if val["all"]
            #  html << "<td>"
            #  html << val["name"].to_s
            #  html << "</td>"
            #  html << "<td colspan=\"#{list['_head'].size - 2}\">"
            #  html << val["all"]
            #  html << "</td>"
            #  html << "<td>"
            #  html << val["desc"].to_s
            #  html << "</td>"
            #else
            all_count = 0
            head.each do |head_val|
              if head_val["all"] && val["all"]
                all_count += 1
                next
              end

              if all_count > 0
                html << "<td colspan=\"#{all_count}\">"
                html << val["all"]
                html << "</td>"
                all_count = 0
              end

              name = head_val["key"]
              if head_val["wrap"]
                html << "<td>"
              else
                html << "<td class=\"text-nowrap\">"
              end

              if val[name].is_a?(Hash)
                content = val[name]["content"]
                note_val = val[name]["note"]
              else
                content = val[name]
                note_val = nil
              end

              if note_val
                note_html_list = []
                Array(note_val).each do |note|
                  if note_list.include?(note)
                    note_num = note_list.index(note) + 1
                  else
                    note_num = note_list.size + 1
                    note_list << note
                  end
                  note_html_list << link_to(
                      "\##{note_num}",
                      "\#note#{note_num}",
                      :class => "pull-right",
                      :"data-toggle" => "popover",
                      :"data-content" => note.gsub(/<[^>]*>/, '').gsub(/&lt;/, '<').gsub(/&gt;/, '>').gsub(/&amp;/, '&'))
                end
                html << note_html_list.reverse.join(" ")
              end

              if content.nil?
                html << head_val["nil"].to_s
              elsif content == true
                html << "○"
              elsif content == false
                html << "×"
              elsif content.is_a?(Array)
                html << content.join("<br>")
              else
                html << content.to_s
              end


              html << "</td>"
            end
            html << "</tr>"
          end
        else
          # 文字列の場合はそれだけを表示
          html << "<tr>"
          html << "<td>"
          html << escape_html(lang)
          html << "</td>"
          html << "<td colspan=\"#{head.size.to_s}\">"
          html << escape_html(val_list)
          html << "</td>"
          html << "</tr>"
        end
      end
      html << "</tbody>"
      html << "</table>"
      html << "</div>"
      if not note_list.empty?
        html << "<div class=\"note small\">"
        html << "<h4>備考</h4>"
        html << "<ol>"
        note_list.size.times do |i|
          html << "<li id=\"note#{i + 1}\">"
          html << note_list[i]
          html << "</li>"
        end
        html << "</ol>"
        html << "</div>"
      end
      html << (<<-'EOS')
        <script>
        //<![CDATA[
        $(function(){
          options = {
            template: '<div class="popover small" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>',
            trigger: 'hover focus',
            placement: 'top',
            container: 'body'}
          $('[data-toggle=popover]').popover(options);
        });
        //]]>
        </script>
      EOS
      return html
    end
  end
end

::Middleman::Extensions.register(:lang_helper, LangHelper)
