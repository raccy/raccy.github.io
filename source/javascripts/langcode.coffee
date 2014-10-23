# jQuery required
# paths = {name0: path0, name1: path1, ...}
@langSelecter = (langList) ->
  for k, v of langList
    $("\#lang-select-#{k}").click ->
      langCode = $(@).attr("id").replace("lang-select-", "")
      selectLang(langList[langCode][0], langList[langCode][1])

@selectLang = (langName, pathList) ->
  $("#lang-name").html(langName)
  #for filename, path of paths
  #  html_src = "<div class=\"panel\""
  #  html_src += "<pre>"
  #  html_src += "</pre>"
  #  $("#lang-code").html(html_src)
  #$("#lang-code").html(langName)
