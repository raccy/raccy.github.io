# jQuery required
# paths = {name0: path0, name1: path1, ...}
@escapeHTML = (str) ->
  return str.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

@langSelecter = (langList) ->
  for k, v of langList
    $("\#lang-select-#{k}").click ->
      langCode = $(@).attr("id").replace("lang-select-", "")
      selectLang(langList[langCode][0], langList[langCode][1])

@idCodeFileName = (filename) ->
  return "code-file-" + filename.replace(".", "_")

@selectLang = (langName, pathList) ->
  $("#lang-name").html(langName)
  html_src = "<div class=\"panel panel-group\">"
  for filename, path of pathList
    html_src += """
        <div class=\"panel panel-default\">
          <div class=\"panel-heading\">
            <h3 class=\"panel-title\">#{filename}
              <a href=\"#{path}\" download=\"#{filename}\">
                <span
                  class=\"glyphicon glyphicon-download-alt\">
                </span>
              </a>
            </h3>
          </div>
          <div class=\"panel-body\"
              id=\"#{idCodeFileName(filename)}\">
            読み込み中・・・
          </div>
        </div>
        """
    $.get path, {filename: filename}, (data) ->
      fn = @.url.split("?")[1].split("=")[1]
      code_src = "<pre><code>" + escapeHTML(data) + "</code></pre>"
      $("\##{idCodeFileName(fn)}").html(code_src)
  html_src += "</div>"
  $("#lang-code").html(html_src)
