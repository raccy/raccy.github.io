# jQuery required
# paths = {name0: path0, name1: path1, ...}
loadingFiles = 0

escapeHTML = (str) ->
  return str.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

idCodeFileName = (filename) ->
  return "code-file-" + filename.replace(".", "_")

selectLang = (langName, pathList) ->
  $("#lang-name").html("#{langName}<span class=\"caret\"></span>")
  $("#lang-name").button("loading")
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
      suffix = fn.split(".")[1]
      code_src = "<pre><code class =\"#{suffix}\">" + escapeHTML(data) +
          "</code></pre>"
      # delay test
      setTimeout ->
        $("\##{idCodeFileName(fn)}").html(code_src)
        $("\##{idCodeFileName(fn)} pre code").each (i, block) ->
          hljs.highlightBlock(block)
      , 1000
  html_src += "</div>"
  $("#lang-code").html(html_src)

@langSelecter = (langList) ->
  for k, v of langList
    $("\#lang-link-#{k}").click ->
      langCode = $(@).attr("id").replace("lang-link-", "")
      selectLang(langList[langCode][0], langList[langCode][1])
