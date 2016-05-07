module Jekyll
    module Postbuild
        class CmdError < StandardError; end

        Jekyll::Hooks.register(:site, :post_write) do |site|
            commands = site.config['postbuild'] || []
            commands.each { |cmd|
                expanded_cmd = cmd % { :baseurl => site.baseurl, :dest => site.dest, :source => site.source }
                result = system(expanded_cmd)

                if (!result)
                    raise CmdError, "Postbuild command returned a non-zero exit code: %s" % expanded_cmd
                end
            }
        end
    end
end