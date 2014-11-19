require "pathname"
require "fileutils"

class LangCode < Middleman::Extension
  option :code_dir, "code", "Direcotry inlude Language codes"
  option :code_suffix, ".txt", "Code file's suffix"

  def initialize(app, options_hash={}, &block)
    super
  end

  helpers do
    def code_download_link_tag(path, text = nil)
      url = code_url(path)
      file_name = File.basename(path)
      text ||= file_name
      return "<a href='#{escape_html(url)}' download='#{escape_html(file_name)}'>#{text}</a>"
    end

    def code_print(path)
      code = IO.read(File.join(extensions[:lang_code].options.code_dir, path), encoding: "UTF-8")
      return code
    end

    def code_url(path)
      url = File.join(http_prefix, extensions[:lang_code].options.code_dir, path + extensions[:lang_code].options.code_suffix)
      return url
    end

    def code_file_search(code_name, path)
      full_path = File.join(extensions[:lang_code].options.code_dir, code_name, path)
      list = {}
      if FileTest.directory?(full_path)
        Dir.foreach(full_path) do |e|
          next if e == "." || e == ".."
          if path == "."
            child_path = e
          else
            child_path = File.join(path, e)
          end
          list.update(code_file_search(code_name, child_path))
        end
        return list
      elsif FileTest.file?(full_path)
        list[path] = code_url(File.join(code_name, path))
      end
      return list
    end

    def code_list(name)
      parent_code_path = File.join(extensions[:lang_code].options.code_dir, name)
      lang_list = {}
      Dir.foreach(parent_code_path) do |e|
        next if e == "." || e == ".."
        if FileTest.directory?(File.join(parent_code_path, e))
          path_list = code_file_search(File.join(name, e), ".")
          lang_list[e] = [data.lang[e], path_list]
        end
      end
      return lang_list
    end
  end

  def all_code_list()
    list = []
    Dir.foreach(options.code_dir) do |e|
      next if e == "." || e == ".."
      list.concat(file_search(options.code_dir, e))
    end
    return list
  end

  def file_search(parrent, name)
    path = File.join(parrent, name)
    if FileTest.directory?(path)
      list = []
      Dir.foreach(path) do |e|
        next if e == "." || e == ".."
        list.concat(file_search(parrent, File.join(name, e)))
      end
      return list
    elsif FileTest.file?(path)
      return [name]
    else
      return []
    end
  end

end

::Middleman::Extensions.register(:lang_code, LangCode)
