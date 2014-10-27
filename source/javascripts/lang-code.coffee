# jQuery.js and highlight.js required
# paths = {name0: path0, name1: path1, ...}
class LangCode

  @escapeHTML: (str) ->
    return str.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

  @idCodeFileName: (filename) ->
    return "code-file-" + filename.replace(/_/g, "__").replace(/\./g, "_2E").replace(/\//g, "_2F")

  constructor: (@langList)->
    @loadingFiles = 0

  # langList = {code0: [name, {filename: path, ... }], ... }
  load: () ->
    for k, v of @langList
      $("\#lang-link-#{k}").click ->
        code = $(@).attr("id").replace("lang-link-", "")
        langCode.selectLang(code)

  selectLang: (code) ->
    langName = @langList[code][0]
    pathList = @langList[code][1]
    $("#lang-name").html("#{langName}<span class=\"caret\"></span>")
    $("#lang-name").button("loading")
    html_src = "<div class=\"panel panel-group\">"
    @loadingFiles = 0
    for filename, path of pathList
      @loadingFiles += 1
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
            <div class=\"panel-body panel-code\"
                id=\"#{LangCode.idCodeFileName(filename)}\">
              読み込み中・・・
            </div>
          </div>
          """
      $.get path, {filename: filename}, (data) ->
        name = @.url.split("?")[1].split("=")[1].replace(/%2F/g, "/")
        suffix = name.split(".")[1]
        code_src = "<pre><code class =\"#{suffix}\">" +
            LangCode.escapeHTML(data) +
            "</code></pre>"
        # delay test
        setTimeout ->
          $("\##{LangCode.idCodeFileName(name)}").html(code_src)
          $("\##{LangCode.idCodeFileName(name)} pre code").each (i, block) ->
            hljs.highlightBlock(block)
          langCode.loadingFiles -= 1
          if langCode.loadingFiles == 0
            $("#lang-name").button("reset")
        , 1000
    html_src += "</div>"
    $("#lang-code").html(html_src)

@langCodeLoad = (langList) ->
  @langCode= new LangCode(langList)
  @langCode.load()
