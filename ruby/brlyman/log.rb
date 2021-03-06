DEFAULT = "\e[39m"
BLUE = "\e[34m"
YELLOW = "\e[33m"
MAGENTA = "\e[35m"

LOG_LINE = " <%{app_name}> %{color}%{type} %{msg} #{DEFAULT}"

class Logger
    @@INDENT = "    "
    def initialize(app_name, verbose)
        @app_name = app_name
        @verbose = verbose
    end

    def info(msg)
        if @verbose
            $stdout.puts LOG_LINE % {
                app_name: @app_name,
                color: BLUE,
                type: "[INFO]",
                msg: "#{msg}"
            }
        end
    end

    def warn(msg)
        if @verbose
            $stdout.puts LOG_LINE % {
                app_name: @app_name,
                color: YELLOW,
                type: "[WARN]",
                msg: "#{msg}"
            }
        end
    end

    def error(msg)
        $stderr.puts LOG_LINE % {
            app_name: @app_name,
            color: MAGENTA,
            type: "[ERROR]",
            msg: "#{msg}"
        }
    end

    def set_name(name)
        @app_name = name
    end

    def name
        @app_name
    end
end

$default_logger = Logger.new "default", true

=begin
Log a message to the console with an [info] prefix and color.
=end
def info(msg)
    $default_logger.info msg
end

=begin
Log a message to the console with an [warn] prefix and color.
=end
def warn(msg)
    $default_logger.warn msg
end

=begin
Log a message to the console with an [error] prefix and color.
=end
def error(msg)
    $default_logger.error msg
end

=begin
Add a prefix name to all logs which execute within the associated block.
=end
def log_block(name)
    old_name = $default_logger.name
    $default_logger.set_name "#{old_name}.#{name}"
    yield
ensure
    $default_logger.set_name old_name
end
