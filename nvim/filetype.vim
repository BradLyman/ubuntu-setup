if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.yml setfiletype yaml
    au! BufRead,BufNewFile *.yaml setfiletype yaml

    au! BufRead,BufNewFile *.ex setfiletype elixir
    au! BufRead,BufNewFile *.exs setfiletype elixir
    au! BufRead,BufNewFile *.ts setfiletype typescript
    au! BufRead,BufNewFile *.ps1 setfiletype powershell
augroup END
