" WEREWOLF
"" version 1.1
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

let s:werewolf_autocmd_allowed = 0

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
			" if we don't do this check, Werewolf's own ColorScheme autocmd will
			" run infinitely; this limits when it happens
			if s:werewolf_autocmd_allowed
				doau ColorScheme Werewolf
				let s:werewolf_autocmd_allowed = 0
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
	let s:werewolf_autocmd_allowed = 0
	call Werewolf#transform(g:werewolf_day_themes + g:werewolf_night_themes, g:werewolf_night_themes + g:werewolf_day_themes)
endfunction

function! Werewolf#autoChange()
	if g:werewolf_change_automatically
		let s:werewolf_autocmd_allowed = 1
		call Werewolf()
	endif
endfunction

augroup werewolf
	autocmd!
	autocmd ColorScheme * nested call Werewolf#colorschemeChanged()
	autocmd CursorMoved,CursorHold,CursorHoldI,WinEnter,WinLeave,FocusLost,FocusGained,VimResized,ShellCmdPost * nested call Werewolf#autoChange()
augroup END

delf <SID>CSet
