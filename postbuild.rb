module Jekyll
    module Postbuild
        class PostbuildCmdError < StandardError; end

        Jekyll::Hooks.register(:site, :post_write) do |site|
            commands = site.config['postbuild'] || []
            commands.each { |cmd|
                expanded_cmd = cmd % { :baseurl => site.baseurl, :dest => site.dest, :source => site.source }
                result = system(expanded_cmd)

                if (!result)
                    err = "Postbuild command returned a non-zero exit code: %s" % expanded_cmd
                    if site.config['watch']
                        STDERR.puts err
                    else
                        raise PostbuildCmdError, err
                    end
                end
            }
        end
    end
end