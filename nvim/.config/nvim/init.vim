"{{{ Plugins
call plug#begin('~/.vim/plugged')
" LSP, debug
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'puremourning/vimspector'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" MISC
Plug 'rafamadriz/friendly-snippets'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-eunuch'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kevinhwang91/nvim-bqf'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'vim-scripts/BufOnly.vim'
Plug 'szw/vim-maximizer'
Plug 'mbbill/undotree'
Plug 'nvim-lua/plenary.nvim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'ThePrimeagen/vim-be-good'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-lua/popup.nvim'
Plug 's1n7ax/nvim-comment-frame'

" File explorer
Plug 'kyazdani42/nvim-tree.lua'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'

"Git
Plug 'tpope/vim-fugitive'
Plug 'kdheepak/lazygit.nvim'
Plug 'lewis6991/gitsigns.nvim'

" Theme
Plug 'tjdevries/colorbuddy.vim'
Plug 'rktjmp/lush.nvim'

Plug 'lifepillar/vim-gruvbox8'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'yonlu/omni.vim'
Plug 'doums/darcula'
Plug 'chiendo97/intellij.vim'
Plug 'folke/tokyonight.nvim'
Plug 'sainnhe/sonokai'
Plug 'marko-cerovac/material.nvim'
Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
Plug 'shaunsingh/moonlight.nvim'
Plug 'arzg/vim-colors-xcode'
Plug 'lourenci/github-colors'
Plug 'MordechaiHadad/nvim-papadark'
Plug 'mcchrish/zenbones.nvim'
call plug#end()
"}}}

lua require('settings')
lua require('mappings')
lua require('theme')
lua require('fzf')
lua require('explorer')
lua require('other')
lua require('git')
lua require('vimspector')
lua require('lsp-coc')

"{{{ LSP configuration

lua << EOF
EOF
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>":
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <cr> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> ]s <cmd>CocCommand document.jumpToNextSymbol<cr>zt
nmap <silent> [s <cmd>CocCommand document.jumpToPrevSymbol<cr>zt

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nnoremap <leader>cs :CocSearch<space>

" Formatting selected code.
xmap <leader>fm  <Plug>(coc-format-selected)
nmap <localleader>fm  <Plug>(coc-format-selected)
nmap <leader>fm :call CocActionAsync('format')<cr>

augroup CocSettings
  autocmd!
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <localleader>ac  <Plug>(coc-codeaction)
nmap <leader>ac  <Plug>(coc-codeaction-line)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>af <cmd>CocCommand tsserver.executeAutofix<cr><cmd>CocCommand eslint.executeAutofix<cr>
if &filetype == "java"
  nnoremap <leader><leader>oi <cmd>CocCommand editor.action.organizeImport<cr>
else
  nnoremap <leader><leader>oi <cmd>CocCommand tsserver.organizeImports<cr>
endif

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

let g:coc_status_warning_sign=" "
let g:coc_status_error_sign=" "

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline=\ %{GetIcon()}\ %.40f\ %m%r\ %{CocStatus()}%=%{GitBranchName()}\ %{GitAttributes()}\ \ %l/%L,%c

function CocStatus()
  let l:ww = winwidth(0)
  if l:ww < 100
    return ''
  endif

  return coc#status()
endfunction

function GetIcon() abort
  let l:buffer_name = expand("%")
  if l:buffer_name == ''
    return ''
  endif

 return luaeval("require'nvim-web-devicons'.get_icon(vim.fn.expand(\"%:t\"), require'plenary.filetype'.detect(vim.api.nvim_buf_get_name(0)), { default = true })")
endfunction

function GitAttributes()
 let l:git_signs = get(b:,'gitsigns_status_dict', {})
 let l:added = get(l:git_signs, 'added', '0')
 let l:removed = get(l:git_signs, 'removed', '0')
 let l:changed = get(l:git_signs, 'changed', '0')
 let l:head = get(l:git_signs, 'head', '')

 if l:head == ''
   return ''
 endif

  return "  " . l:added .  " 柳" . l:changed .  "  " . l:removed
endfunction

function GitBranchName()
 let l:git_signs = get(b:,'gitsigns_status_dict', {})
 let l:head = get(l:git_signs, 'head', '')
 let l:limit = 18

 if l:head == ''
   return ''
 endif

 if strlen(l:head) > l:limit
  return  "   " . strpart(l:head, 0, 8) . "..." . strpart(l:head, strlen(l:head) - 10)
endif

  return  "   " .  l:head
endfunction

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>da  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <localleader>da  <cmd>CocDiagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList marketplace<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>ws  :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>cr  :<C-u>CocListResume<cr>

" :h CocLocationsChange for detail
let g:coc_enable_locationlist = 0
augroup Coc
    autocmd!
    autocmd User CocLocationsChange ++nested call Coc_qf_jump2loc(g:coc_jump_locations)
augroup END

nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <leader>da <Cmd>call Coc_qf_diagnostic()<CR>

function! Coc_qf_diagnostic() abort
    let diagnostic_list = CocAction('diagnosticList')
    let items = []
    let loc_ranges = []
    for d in diagnostic_list
        let type = d.severity[0]
        let text = printf('[%s%s] %s [%s]', (empty(d.source) ? 'coc.nvim' : d.source),
                    \ (d.code ? ' ' . d.code : ''), split(d.message, '\n')[0], type)
        let item = {'filename': d.file, 'lnum': d.lnum, 'col': d.col, 'text': text, 'type': type}
        call add(loc_ranges, d.location.range)
        call add(items, item)
    endfor
    call setqflist([], ' ', {'title': 'CocDiagnosticList', 'items': items,
                \ 'context': {
                  \ 'bqf': {'lsp_ranges_hl': loc_ranges}
                  \}
                \})
    botright copen
endfunction

function! Coc_qf_jump2loc(locs) abort
    let loc_ranges = map(deepcopy(a:locs), 'v:val.range')
    call setloclist(0, [], ' ', {'title': 'CocLocationList', 'items': a:locs,
                \ 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}
                \}
                \})
    let winid = getloclist(0, {'winid': 0}).winid
    if winid == 0
        aboveleft lwindow
    else
        call win_gotoid(winid)
    endif
  endfunction
"}}}

