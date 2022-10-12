vim.cmd([[
    if executable('tfdoc')
        command! -nargs=* Tfdoc :call system('tfdoc' . ' ' . <q-args>)
    endif
    nnoremap <silent> <Leader><Leader>r :Tfdoc <C-R><C-W><CR>
    nnoremap <silent> <Leader><Leader>d :Tfdoc -d <C-R><C-W><CR>
    xnoremap <silent> <Leader><Leader>r y:Tfdoc <C-R>"<CR>
    xnoremap <silent> <Leader><Leader>d y:Tfdoc -d <C-R>"<CR>

]])
