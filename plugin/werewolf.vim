" WEREWOLF
"" version 1.0
"" changes your colorscheme depending on the time of day
"" by Jonathan Stoler

function! <SID>CSet(name, default)
	if(!exists(a:name))
		execute "let " . a:name . " = " . a:default
	endif
endfunction

call <SID>CSet("g:werewolf_day_themes", "[]")
call <SID>CSet("g:werewolf_night_themes", "[]")
call <SID>CSet("g:werewolf_day_start", 8)
call <SID>CSet("g:werewolf_day_end", 20)
call <SID>CSet("g:werewolf_change_automatically", 1)

function! Werewolf()
	if strftime("%H") >= g:werewolf_day_start && strftime("%H") < g:werewolf_day_end
		call Werewolf#transform(g:werewolf_night_themes, g:werewolf_day_themes)
	else
		call Werewolf#transform(g:werewolf_day_themes, g:werewolf_night_themes)
	endif
endfunction

function! Werewolf#transform(current, switch)
	" get current colorscheme
	let s:cs = ''
	redir => cs
		silent colorscheme
	redir END
	let cs = cs[1:]

	let i = 0
	while i < len(a:current)
		if cs ==# a:current[i]
			execute "colorscheme " . a:switch[i]
			" simple airline support - make airline transform, too
			if(exists("airline#load_theme()"))
				call airline#load_theme()
			endif

			return
		endif
		let i += 1
	endwhile
endfunction

function! WerewolfToggle()
	call Werewolf#colorschemeChanged()
endfunction

function! Werewolf#colorschemeChanged()
	call Werewolf#transform(g:werewolf_day_themes + g:werewolf_night_themes, g:werewolf_night_themes + g:werewolf_day_themes)
endfunction

function! Werewolf#autoChange()
	if g:werewolf_change_automatically
		call Werewolf()
	endif
endfunction

augroup werewolf
	autocmd!
	autocmd ColorScheme * call Werewolf#colorschemeChanged()
	autocmd CursorMoved,CursorHold,CursorHoldI,WinEnter,WinLeave,FocusLost,FocusGained,VimResized,ShellCmdPost * call Werewolf#autoChange()
augroup END

delf <SID>CSet
