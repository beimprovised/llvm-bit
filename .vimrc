	:set nowrap
	:set paste
	" put this line first in ~/.vimrc
        set nocompatible | filetype indent plugin on | syn on

        fun! EnsureVamIsOnDisk(plugin_root_dir)
          " windows users may want to use http://mawercer.de/~marc/vam/index.php
          " to fetch VAM, VAM-known-repositories and the listed plugins
          " without having to install curl, 7-zip and git tools first
          " -> BUG [4] (git-less installation)
          let vam_autoload_dir = a:plugin_root_dir.'/vim-addon-manager/autoload'
          if isdirectory(vam_autoload_dir)
            return 1
          else
            if 1 == confirm("Clone VAM into ".a:plugin_root_dir."?","&Y\n&N")
              " I'm sorry having to add this reminder. Eventually it'll pay off.
              call confirm("Remind yourself that most plugins ship with ".
                          \"documentation (README*, doc/*.txt). It is your ".
                          \"first source of knowledge. If you can't find ".
                          \"the info you're looking for in reasonable ".
                          \"time ask maintainers to improve documentation")
              call mkdir(a:plugin_root_dir, 'p')
              execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.
                          \       shellescape(a:plugin_root_dir, 1).'/vim-addon-manager'
              " VAM runs helptags automatically when you install or update 
              " plugins
              exec 'helptags '.fnameescape(a:plugin_root_dir.'/vim-addon-manager/doc')
            endif
            return isdirectory(vam_autoload_dir)
          endif
        endfun

        fun! SetupVAM()
          " Set advanced options like this:
          " let g:vim_addon_manager = {}
          " let g:vim_addon_manager.key = value
          "     Pipe all output into a buffer which gets written to disk
          " let g:vim_addon_manager.log_to_buf =1

          " Example: drop git sources unless git is in PATH. Same plugins can
          " be installed from www.vim.org. Lookup MergeSources to get more control
          " let g:vim_addon_manager.drop_git_sources = !executable('git')
          " let g:vim_addon_manager.debug_activation = 1

          " VAM install location:
          let c = get(g:, 'vim_addon_manager', {})
          let g:vim_addon_manager = c
          let c.plugin_root_dir = expand('$HOME/.vim/vim-addons', 1)
          if !EnsureVamIsOnDisk(c.plugin_root_dir)
            echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
            return
          endif
          let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'

          " Tell VAM which plugins to fetch & load:
          call vam#ActivateAddons(['taglist'], {'auto_install' : 0})
          " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
          " Also See "plugins-per-line" below
	  "		ActivateAddons scrooloose/nerdtree
          " Addons are put into plugin_root_dir/plugin-name directory
          " unless those directories exist. Then they are activated.
          " Activating means adding addon dirs to rtp and do some additional
          " magic

          " How to find addon names?
          " - look up source from pool
          " - (<c-x><c-p> complete plugin names):
          " You can use name rewritings to point to sources:
          "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
          "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
          " Also see section "2.2. names of addons and addon sources" in VAM's documentation
        endfun
        call SetupVAM()
        " experimental [E1]: load plugins lazily depending on filetype, See
        " NOTES
        " experimental [E2]: run after gui has been started (gvim) [3]
        " option1:  au VimEnter * call SetupVAM()
        " option2:  au GUIEnter * call SetupVAM()
        " See BUGS sections below [*]
        " Vim 7.0 users see BUGS section [3]

	" Activate Addons Management
	" let g:vim_addon_manager = { 'known_repos_activation_policy' : 'never', 'auto_install' : 1, 'plugin_sources' : {} }
"	let g:vim_addon_manager.plugin_sources['nerd_commenter'] = {'type': 'git', 'url': 'git://github.com/scrooloose/nerdcommenter.git'}
"	let g:vim_addon_manager.plugin_sources['surround'] = {'type': 'git', 'url': 'git://github.com/tpope/vim-surround.git'}
"	let g:vim_addon_manager.plugin_sources['repeat'] = {'type': 'git', 'url': 'git://github.com/tpope/vim-repeat.git'}
"	let g:vim_addon_manager.plugin_sources['supertab'] = {'type': 'git', 'url': 'git://github.com/ervandew/supertab.git'}
"	let g:vim_addon_manager.plugin_sources['align'] = {'version': '35/41', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=10110', 'vim_version': '7.0', 'date': '2009-03-04', 'vim_script_nr': 294, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'Align.vba.gz', 'author': 'Charles Campbell'}
"	let g:vim_addon_manager.plugin_sources['sqlutil'] = {'version': '4.00', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=13576', 'vim_version': '7.0', 'date': '2010-08-15', 'vim_script_nr': 492, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'sqlutil_400.zip', 'author': 'David Fishburn'}
"	let g:vim_addon_manager.plugin_sources['taglist'] = {'version': '4.5', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=7701', 'vim_version': '6.0', 'date': '2007-09-21', 'vim_script_nr': 273, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'taglist_45.zip', 'author': 'Yegappan Lakshmanan'}
"	let g:vim_addon_manager.plugin_sources['fuzzyfinder'] = {'type': 'hg', 'url': 'http://bitbucket.org/ns9tks/vim-fuzzyfinder'}
"	let g:vim_addon_manager.plugin_sources['nerd_tree'] = {'version': '4.1.0', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=11834', 'vim_version': '7.0', 'date': '2009-12-01', 'vim_script_nr': 1658, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'NERD_tree.zip', 'author': 'Marty Grenfell'}
"	let g:vim_addon_manager.plugin_sources['L9'] = {'type': 'hg', 'url': 'http://bitbucket.org/ns9tks/vim-l9'}
"	let g:vim_addon_manager.plugin_sources['xptemplate'] = {'version': '0.4.8-r994', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=13740', 'vim_version': '7.2', 'date': '2010-09-01', 'vim_script_nr': 2611, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'xpt-0.4.8-r994.tgz', 'author': 'drdr xp'}
"	let g:vim_addon_manager.plugin_sources['xptemplate']['strip-components'] = 0
"	let g:vim_addon_manager.plugin_sources['command-T'] = { 'type' : 'git', 'url' : 'git://git.wincent.com/command-t.git' }
"	let g:vim_addon_manager.plugin_sources['tcalc'] = {'version': '0.11', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=8028', 'vim_version': '7.0', 'date': '2007-12-05', 'vim_script_nr': 2040, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'tcalc.zip', 'author': 'Tom Link'}
"	let g:vim_addon_manager.plugin_sources['bufexplorer'] = {'version': '7.2.7', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=12904', 'vim_version': '7.0', 'date': '2010-04-26', 'vim_script_nr': 42, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'bufexplorer.zip', 'author': 'jeff lanzarotta'}
"	let g:vim_addon_manager.plugin_sources['ack'] = {'type': 'git', 'url': 'http://github.com/mileszs/ack.vim.git' }
"	let g:vim_addon_manager.plugin_sources['genutils'] = {'version': '2.5', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=11399', 'vim_version': '7.0', 'date': '2009-09-17', 'vim_script_nr': 197, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'genutils-2.5.zip', 'author': 'Hari Krishna Dara'}
"	let g:vim_addon_manager.plugin_sources['matchit'] = {'version': '1.13.2', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=8196', 'vim_version': '6.0', 'date': '2008-01-29', 'vim_script_nr': 39, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'matchit.zip', 'author': 'Benji Fisher'}
"	let g:vim_addon_manager.plugin_sources['arpeggio'] = {'type': 'git', 'url': 'http://github.com/kana/vim-arpeggio.git' }
"	let g:vim_addon_manager.plugin_sources['minibufexplorer'] = {'version': '6.3.3', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=13838', 'vim_version': '7.0', 'date': '2010-09-15', 'vim_script_nr': 3239, 'type': 'archive', 'script-type': 'plugin', 'archive_name': 'minibufexplpp.vim', 'author': 'Oliver Uvman'}
"	let g:vim_addon_manager.plugin_sources['vorax'] = {'title': 'vorax', 'version': '2.5', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=14147', 'vim_version': '7.0', 'date': '2010-10-02', 'vim_script_nr': 3154, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'vorax-2.5.zip', 'author': 'Alexandru Tica'} 
"
	fun! PoolFunImpl()
		let d = vam#install#Pool()
		" let d.my_plugin = { 'type' : 'git', 'url' : ' ... ' }
		let d.nerd_commenter = {'type': 'git', 'url': 'git://github.com/scrooloose/nerdcommenter.git'}
		let d.surround = {'type': 'git', 'url': 'git://github.com/tpope/vim-surround.git'}
		let d.repeat = {'type': 'git', 'url': 'git://github.com/tpope/vim-repeat.git'}
		let d.supertab = {'type': 'git', 'url': 'git://github.com/ervandew/supertab.git'}
		let d.align = {'version': '35/41', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=10110', 'vim_version': '7.0', 'date': '2009-03-04', 'vim_script_nr': 294, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'Align.vba.gz', 'author': 'Charles Campbell'}
		let d.sqlutil = {'version': '4.00', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=13576', 'vim_version': '7.0', 'date': '2010-08-15', 'vim_script_nr': 492, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'sqlutil_400.zip', 'author': 'David Fishburn'}
		let d.taglist = {'version': '4.5', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=7701', 'vim_version': '6.0', 'date': '2007-09-21', 'vim_script_nr': 273, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'taglist_45.zip', 'author': 'Yegappan Lakshmanan'}
		" let d.fuzzyfinder = {'type': 'hg', 'url': 'http://bitbucket.org/ns9tks/vim-fuzzyfinder'}
		let d.nerd_tree = {'version': '4.1.0', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=11834', 'vim_version': '7.0', 'date': '2009-12-01', 'vim_script_nr': 1658, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'NERD_tree.zip', 'author': 'Marty Grenfell'}
		let d.nerdtree = {'type':'git', 'url': 'https://github.com/scrooloose/nerdtree'}		
		let d.vimux = {'type':'git', 'url': 'https://github.com/benmills/vimux'}		
		" let d.L9 = {'type': 'hg', 'url': 'http://bitbucket.org/ns9tks/vim-l9'}
		" let d.cmake-project = {'type': 'git', 'url': 'git://github.com/Ignotus/vim-cmake-project.git'}
		" let d.cmake-project = {'type': 'git', 'url': 'git://github.com/sigidagi/vim-cmake-project.git'}
		let d.xptemplate = {'version': '0.4.8-r994', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=13740', 'vim_version': '7.2', 'date': '2010-09-01', 'vim_script_nr': 2611, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'xpt-0.4.8-r994.tgz', 'author': 'drdr xp'}
		let d.xptemplate.strip-components = 0
		" let d.command-T = { 'type' : 'git', 'url' : 'git://git.wincent.com/command-t.git' }
		let d.tcalc = {'version': '0.11', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=8028', 'vim_version': '7.0', 'date': '2007-12-05', 'vim_script_nr': 2040, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'tcalc.zip', 'author': 'Tom Link'}
		let d.bufexplorer = {'version': '7.2.7', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=12904', 'vim_version': '7.0', 'date': '2010-04-26', 'vim_script_nr': 42, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'bufexplorer.zip', 'author': 'jeff lanzarotta'}
		let d.ack = {'type': 'git', 'url': 'http://github.com/mileszs/ack.vim.git' }
		let d.genutils = {'version': '2.5', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=11399', 'vim_version': '7.0', 'date': '2009-09-17', 'vim_script_nr': 197, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'genutils-2.5.zip', 'author': 'Hari Krishna Dara'}
		let d.matchit = {'version': '1.13.2', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=8196', 'vim_version': '6.0', 'date': '2008-01-29', 'vim_script_nr': 39, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'matchit.zip', 'author': 'Benji Fisher'}
		let d.arpeggio = {'type': 'git', 'url': 'http://github.com/kana/vim-arpeggio.git' }
		let d.minibufexplorer = {'version': '6.3.3', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=13838', 'vim_version': '7.0', 'date': '2010-09-15', 'vim_script_nr': 3239, 'type': 'archive', 'script-type': 'plugin', 'archive_name': 'minibufexplpp.vim', 'author': 'Oliver Uvman'}
		let d.vorax = {'title': 'vorax', 'version': '2.5', 'url': 'http://www.vim.org/scripts/download_script.php?src_id=14147', 'vim_version': '7.0', 'date': '2010-10-02', 'vim_script_nr': 3154, 'type': 'archive', 'script-type': 'utility', 'archive_name': 'vorax-2.5.zip', 'author': 'Alexandru Tica'} 
		let d.vimprojectmanage = {'type': 'git', 'url': 'git://github.com/shemerey/vim-project.git'}
		let d.backgroundcmd = {'type': 'git', 'url': 'git://github.com/MarcWeber/vim-addon-background-cmd.git'}
		let d.local_vimrc = {'type': 'git', 'url': 'git://github.com/LucHermitte/local_vimrc.git'}
		let d.sessions = {'type': 'git', 'url': 'https://github.com/edsono/vim-sessions.git'}
		let d.build_tools = {'type': 'git', 'url': 'git://github.com/LucHermitte/vim-build-tools-wrapper.git'}
		let d.code_pull = {'type': 'git', 'url': 'git://github.com/kasandell/Code-Pull.git'}
		let d.pycmake = {'type': 'git', 'url': 'git://github.com/po1/vim-pycmake.git'}
		let d.openproject = {'type': 'git', 'url': 'git://github.com/rscarvalho/OpenProject.vim.git'}
		let d.vimprojectrc = {'type': 'git', 'url': 'git://github.com/mattolenik/vim-projectrc.git'}
		let d.project_tags = {'type': 'git', 'url': 'git://github.com/still-dreaming-1/vim-project-tags.git'}
		let d.nerdtree_tabs = {'type': 'git', 'url': 'git://github.com/jistr/vim-nerdtree-tabs.git'}
		let d.unite_outline = {'type': 'git', 'url': 'git://github.com/Shougo/unite-outline.git'}
		" let d.ctags = {'type': 'git', 'url': 'git://github.com/szw/vim-tags.git'}
		" let d.ctags = {'type': 'git', 'url': 'https://github.com/vim-scripts/ctags.vim.git'}
		let d.ctags = {'type': 'git', 'url': 'https://github.com/majutsushi/ctags.git'}
		let d.powerline = {'type': 'git', 'url': 'git://github.com/powerline/powerline.git'}
		let d.tagbar = {'type': 'git', 'url': 'https://github.com/majutsushi/tagbar.git'}
		let d.buftabline = {'type': 'git', 'url': 'https://github.com/ap/vim-buftabline.git'}
		let d.wintabs = {'type': 'git', 'url': 'https://github.com/zefei/vim-wintabs.git'}
		let d.ctrlp = {'type': 'git', 'url': 'https://github.com/ctrlpvim/ctrlp.vim.git'}
	    return d
	endfun

	"call PoolFunImpl()

	let g:vim_addon_manager.pool_fun = function('PoolFunImpl')
	" Activate Addons Management
	let g:vim_script_manager = { 'known_repos_activation_policy' : 'autoload', 'auto_install' : 1 }	

	fun! ActivateAddonsExt()
		let addons_base = substitute(expand('$HOME') . '/.vim/vim-addons', '\\\\\|\\', '/', 'g')
		" check if addons_base folder is there
		if finddir(addons_base, '') == ''
			call mkdir(addons_base, '')
		endif
		let addons_manager = addons_base . '/vim-addon-manager'
		exe 'set runtimepath+=' . escape(addons_manager, ' ')
		if finddir(addons_manager) == ''
		" The addons manager is not installed. Install it now!
			exe 'cd ' . addons_base
			exe '!git clone git://github.com/MarcWeber/vim-addon-manager.git'
		endif
"		call vam#ActivateAddons(['nerd_commenter',
"		\ 'surround',
"		\ 'repeat',
"		\ 'supertab',
"		\ 'align',
"		\ 'sqlutil',
"		\ 'vorax',
"		\ 'nerdtree',
"		\ 'vimux',
"		\ 'nerd_tree',
"		\ 'genutils',
"		\ 'bufexplorer',
"		\ 'matchit',
"		\ 'minibufexplorer',
"		\ 'vorax',
"		\ 'tcalc',
"		\ 'vimprojectmanage',
"		\ 'backgroundcmd',
"		\ 'local_vimrc',
"		\ 'sessions',
"		\ 'build_tools',
"		\ 'code_pull',
"		\ 'openproject',
"		\ 'vimprojectrc',
"		\ 'unite_outline',
"		\ 'ctags',
"		\ 'powerline',
"		\ 'tagbar',
"		\ 'buftabline',
"		\ 'xptemplate'], {'auto_install' : 0})

		call vam#ActivateAddons(['nerd_commenter',
		\ 'surround',
		\ 'repeat',
		\ 'supertab',	
		\ 'align',
		\ 'sqlutil',
		\ 'vorax',
		\ 'nerdtree',
		\ 'nerdtree_tabs',
		\ 'vimux',
		\ 'genutils',
		\ 'bufexplorer',
		\ 'matchit',
		\ 'vorax',
		\ 'tcalc',
		\ 'vimprojectmanage',
		\ 'backgroundcmd',
		\ 'local_vimrc',
		\ 'sessions',
		\ 'build_tools',
		\ 'code_pull',
		\ 'openproject',
		\ 'vimprojectrc',
		\ 'unite_outline',
		\ 'ctags',
		\ 'powerline',
		\ 'tagbar',
		\ 'ctrlp',
		\ 'minibufexplorer',
		\ 'xptemplate'], {'auto_install' : 0})
	endfun
	call ActivateAddonsExt()	
	
	autocmd vimenter * NERDTree
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
	map <C-n> :NERDTreeToggle<CR>
	map <Leader>n <plug>NERDTreeTabsToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	let g:NERDTreeDirArrowExpandable = '▸'
	let g:NERDTreeDirArrowCollapsible = '▾'
	let g:nerdtree_tabs_open_on_console_startup=1

set exrc
set secure
set hidden
nnoremap <C-h> :bnext<CR>
nnoremap <C-l> :bprev<CR>

" map <C-H> <Plug>(wintabs_previous)
" map <C-L> <Plug>(wintabs_next)
" map <C-T>c <Plug>(wintabs_close)
" map <C-T>o <Plug>(wintabs_only)
" map <C-W>c <Plug>(wintabs_close_window)
" map <C-W>o <Plug>(wintabs_only_window)
" command! Tabc WintabsCloseVimtab
" command! Tabo WintabsOnlyVimtab
" 
let g:vim_tags_auto_generate = 1
let g:vim_tags_ctags_binary = system("${which ctags}")
let g:vim_tags_project_tags_command = "{CTAGS} -R {OPTIONS} {DIRECTORY} 2>/dev/null"
let g:vim_tags_gems_tags_command = "{CTAGS} -R {OPTIONS} `bundle show --paths` 2>/dev/null"
let g:vim_tags_use_vim_dispatch = 0
let g:vim_tags_use_language_field = 1
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore']
let g:vim_tags_ignore_file_comment_pattern = '^[#"]'
let g:vim_tags_directories = [".git", ".hg", ".svn", ".bzr", "_darcs", "CVS"]
let g:vim_tags_main_file = 'tags'
let g:vim_tags_extension = '.tags'
let g:vim_tags_cache_dir = expand($HOME)
nmap <F8> :TagbarToggle<CR>
set tags=./tags,tags;$HOME
set autochdir


" " Rename tabs to show tab number.
" " (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
" if exists("+showtabline")
"     function! MyTabLine()
"         let s = ''
"         let wn = ''
"         let t = tabpagenr()
"         let i = 1
"         while i <= tabpagenr('$')
"             let buflist = tabpagebuflist(i)
"             let winnr = tabpagewinnr(i)
"             let s .= '%' . i . 'T'
"             let s .= (i == t ? '%1*' : '%2*')
"             let s .= ' '
"             let wn = tabpagewinnr(i,'$')
" 
"             let s .= '%#TabNum#'
"             let s .= i
"             " let s .= '%*'
"             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
"             let bufnr = buflist[winnr - 1]
"             let file = bufname(bufnr)
"             let buftype = getbufvar(bufnr, 'buftype')
"             if buftype == 'nofile'
"                 if file =~ '\/.'
"                     let file = substitute(file, '.*\/\ze.', '', '')
"                 endif
"             else
"                 let file = fnamemodify(file, ':p:t')
"             endif
"             if file == ''
"                 let file = '[No Name]'
"             endif
"             let s .= ' ' . file . ' '
"             let i = i + 1
"         endwhile
"         let s .= '%T%#TabLineFill#%='
"         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
"         return s
"     endfunction
"     set stal=2
"     set tabline=%!MyTabLine()
"     set showtabline=1
"     highlight link TabNum Special
" endif
" 

set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                let s .= ' '
                " set page number string
                let s .= t + 1 . ' '
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(t + 1)
                        " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                        " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                        if getbufvar( b, "&buftype" ) == 'help'
                                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                        elseif getbufvar( b, "&buftype" ) == 'quickfix'
                                let n .= '[Q]'
                        else
                                let n .= pathshorten(bufname(b))
                        endif
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        if bc > 1
                                let n .= ' '
                        endif
                        let bc -= 1
                endfor
                " add modified label [n+] where n pages in tab are modified
                if m > 0
                        let s .= '[' . m . '+]'
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999Xclose'
        endif
        return s
endfunction




