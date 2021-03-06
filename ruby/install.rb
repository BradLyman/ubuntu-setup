#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
    info "install ruby-dev"
    system "sudo apt-get install ruby-dev"

    info "install rb-inotify"
    system "sudo gem install rb-inotify"

    info "install my ruby scripts"
    system "cp -r ./* ~/.config/mybin"
    system "rm ~/.config/mybin/install.rb" # don't let this file get moved

    log_block "language server" do
        info "install ruby rls: solargraph"
        system "sudo gem install solargraph"
    end
end

def uninstall
    info "remove my ruby scripts"
    system "rm -r ~/.config/mybin/brlyman"
    system "rm -r ~/.config/mybin/onChange.rb"

    log_block "language servers" do
        info "install ruby rls: solargraph"
        system "sudo gem uninstall solargraph"
    end
end

if ARGV.first == "-u"
    uninstall
else
    install
end

