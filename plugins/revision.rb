module Jekyll

  # add post.file_name and post.full_path
  class Post
    alias_method :original_to_liquid, :to_liquid

    def to_liquid
      original_to_liquid.deep_merge({
        'file_name' => @name,
        'full_path' => File.join(@base, @name)
      })
    end
  end

  class RevisionTag < Liquid::Tag
    DEFAULT_LIMIT = 5

    def initialize(name, marker, token)
      @params = Hash[*marker.split(/(?:: *)|(?:, *)/)]
      if @params['limit'] != nil
        /\d*/.match(@params['limit']) do |m|
          @limit = m[0].to_i
        end
      else
        @limit = DEFAULT_LIMIT
      end
      super
    end

    def render(context)
      site = context.environments.first['site']
      if site['github_user'] == nil || site['github_repo'] == nil
        puts 'Uh-oh, site is nil'
        return ''
      end

      post = context.environments.first['post']
      if post == nil
        post = context.environments.first['page']
        if post == nil
          puts 'Uh-oh, post is nil'
          return ''
        end
      end

      full_path = post['full_path']
      if full_path == nil
        puts post['title'] + ' full path is nil'
        return ''
      end

      cmd = 'git log --date=local --pretty="%cd|%s" --max-count=' + @limit.to_s + ' ' + full_path
      logs = `#{cmd}`

      html = '<ul>'
      logs.each_line do |line|
        parts = line.split('|')
        date, msg = parts[0], parts[1..-1].join('|') # keep origin pileline from logs
        html << '<li><strong>' + date + '</strong><br/>' + msg + '</li>'
      end
      html << '</ul>'

      cmd = 'git rev-parse --abbrev-ref HEAD'
      # chop last '\n' of branch name
      branch = `#{cmd}`.chop
      if site['source'] != nil
        # for Octopress sites
        link = File.join('https://github.com', site['github_user'], site['github_repo'],
                         'commits', branch, site['source'], '_posts', post['file_name'])
      else
        # for Jekyll sites
        link = File.join('https://github.com', site['github_user'], site['github_repo'],
                         'commits', branch, '_posts', post['file_name'])
      end
      html << 'View on <a href=' + link + ' target=_blank>Github</a>'

      return html
    end #render
  end # RevisionTag
end # Jekyll

Liquid::Template.register_tag('revision', Jekyll::RevisionTag)
