module Jekyll
    module Postbuild
        class PostbuildCmdError < StandardError; end

        Jekyll::Hooks.register(:site, :post_write) do |site|
            commands = site.config['postbuild'] || []
            commands.each { |cmd|
                all_pages = site.pages.collect { |p| File.join(site.dest, p.path) }
                html_pages = all_pages.select{ |p| p.end_with? '.html' }
                all_pages = "'#{all_pages.join("' '")}'"
                html_pages = "'#{html_pages.join("' '")}'"

                expanded_cmd = cmd % {
                    :baseurl => site.baseurl,
                    :dest => site.dest,
                    :source => site.source,
                    :pages => all_pages,
                    :html_pages => html_pages }
                result = system(expanded_cmd)

                if (!result)
                    err = "Postbuild command returned a non-zero exit code: %s" % expanded_cmd
                    if site.config['watch']
                        STDERR.puts err
                    else
                        raise PostBuildCmdError, err
                    end
                end
            }
        end
    end
end