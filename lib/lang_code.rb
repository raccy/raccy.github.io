require "cgi"
require "pathname"
require "fileutils"

class LangCode < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
    app.set :code_dir, "code"
    app.set :code_suffix, ".txt"
  end

  helpers do
    def code_download_link_tag(path, text = nil)
      url = code_url(path)
      file_name = CGI.escape_html(File.basename(path))
      text ||= file_name
      return "<a href='#{url}' download='#{file_name}'>#{text}</a>"
    end

    def code_print(path)
      code = IO.read(File.join(code_dir, path), encoding: "UTF-8")
      return code
    end

    def code_url(path)
      url = File.join(http_prefix, code_dir, path + code_suffix)
      return url
    end

    def code_file_search(code_name, path)
      full_path = File.join(code_dir, code_name, path)
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
      parent_code_path = File.join(code_dir, name)
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

  def after_configuration
    src = app.settings.code_dir
    dst = File.join(app.settings.source, app.settings.code_dir)
    sync_symlink(src, dst)
  end

  def sync_symlink(src, dst)
    if FileTest.file?(src)
      dst = dst + app.settings.code_suffix
      link_name = Pathname.new(src).
          relative_path_from(Pathname.new(dst).dirname).to_s
      if FileTest.exist?(dst)
        if FileTest.symlink?(dst)
          if File.readlink(dst) != link_name
            app.logger.info "        link  #{dst}"
            FileUtils.symlink(link_name, dst, force: true)
          end
        else
          raise "File exist, but not symlink: #{dst}"
        end
      else
        app.logger.info  "        link  #{dst}"
        FileUtils.symlink(link_name, dst)
      end
    elsif FileTest.directory?(src)
      unless FileTest.directory?(dst)
        app.logger.info  "       mkdir  #{dst}"
        FileUtils.mkdir(dst)
      end
      Dir.foreach(src) do |e|
        if e == "." || e == ".."
          next
        end
        child_src = File.join(src, e)
        child_dst = File.join(dst, e)
        sync_symlink(child_src, child_dst)
      end
      # TODO: cleanup?
    end
    return true
  end
end

::Middleman::Extensions.register(:lang_code, LangCode)
