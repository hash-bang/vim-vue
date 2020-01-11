" Vim indent file
" Language: Vue.js
" Maintainer: Ilia Loginov
" Original Author: Adriaan Zonnenberg

if exists('b:did_indent')
  finish
endif

function! s:get_indentexpr(language)
  unlet! b:did_indent
  execute 'runtime! indent/' . a:language . '.vim'
  return &indentexpr
endfunction

" The order is important here, tags without attributes go last.
" HTML is left out, it will be used when there is no match.
let s:languages = [
      \   { 'name': 'pug', 'pairs': ['<template', '</template>'] },
      \   { 'name': 'stylus', 'pairs': ['<style', '</style>'] },
      \   { 'name': 'javascript', 'pairs': ['<component', '</component>'] },
      \   { 'name': 'javascript', 'pairs': ['<directive', '</directive>'] },
      \   { 'name': 'markdown', 'pairs': ['<docs', '</docs>'] },
      \   { 'name': 'javascript', 'pairs': ['<endpoint', '</endpoint>'] },
      \   { 'name': 'javascript', 'pairs': ['<filter', '</filter>'] },
      \   { 'name': 'javascript', 'pairs': ['<macgyver', '</macgyver>'] },
      \   { 'name': 'javascript', 'pairs': ['<schema', '</schema>'] },
      \   { 'name': 'javascript', 'pairs': ['<script', '</script>'] },
      \   { 'name': 'javascript', 'pairs': ['<server', '</server>'] },
      \   { 'name': 'javascript', 'pairs': ['<service', '</service>'] },
      \   { 'name': 'css', 'pairs': ['<style', '</style>'] },
      \   { 'name': 'html', 'pairs': ['<template', '</template>'] },
      \ ]

for s:language in s:languages
  " Set 'indentexpr' if the user has an indent file installed for the language
  if strlen(globpath(&rtp, 'indent/'. s:language.name .'.vim'))
    let s:language.indentexpr = s:get_indentexpr(s:language.name)
  endif
endfor

let b:did_indent = 1

" Disabled by MC as this really buggers up indenting the way I like it - MC 2019-05-23
setlocal indentexpr=GetJavascriptIndent
" setlocal indentexpr=GetVueIndent()

if exists('*GetVueIndent')
  finish
endif

function! GetVueIndent()
  for language in s:languages
    let opening_tag_line = searchpair(language.pairs[0], '', language.pairs[1], 'bWr')

    if opening_tag_line
      execute 'let indent = ' . get(language, 'indentexpr', -1)
      break
    endif
  endfor

  if exists('l:indent')
    if (opening_tag_line == prevnonblank(v:lnum - 1) || opening_tag_line == v:lnum)
          \ || getline(v:lnum) =~ '\v^\s*\</(script|style|template)'
      return 0
    endif
  endif

  return indent
endfunction
