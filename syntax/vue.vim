" Vim syntax file
" Language:	Vue
" Author:	Ilia Loginov <iloginow@outlook.com>
" Created:	Feb 2, 2018

if !exists("main_syntax")
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'vue'
endif

" ===============================================
" IMPORT PUG, JS AND STYLUS
" ===============================================
syntax include @CSS syntax/css.vim
syntax include @HTML syntax/html.vim
syntax include @JS syntax/javascript.vim
syntax include @MARKDOWN syntax/markdown.vim

" ===============================================
" MAIN TAGS
" ===============================================
syntax match vueEnclosure "\(<\|>\)"
      \ contained

highlight def link vueEnclosure SpecialChar

syntax match vueOperator "="
      \ contained

highlight def link vueOperator Operator

syntax match vueAttribute "\<\(\w\|-\)*\(\>\|=\@=\|>\@=\)"
      \ contained

highlight def link vueAttribute Type

syntax region vueString start=/\('\|"\)/ end=/\('\|"\)/
      \ contained
      \ keepend
      \ oneline

highlight def link vueString String

syntax match vueKeyword "\(<\/\=\)\@<=\(component\|directive\|docs\|endpoint\|filter\|macgyver\|schema\|script\|server\|service\|style\|template\)\>"
      \ contained

highlight def link vueKeyword ModeMsg

syntax region vueMainTag matchgroup=vueEnclosure start="<\/\=\(component\|directive\|docs\|endpoint\|filter\|macgyver\|schema\|script\|server\|service\|style\|template\)\@=" end=">"
      \ contains=vueKeyword,vueOperator,vueString,vueAttribute
      \ keepend
      \ oneline

" ===============================================
" DEFINE TEMPLATE, SCRIPT AND STYLE
" ===============================================

syntax region vueScript start="<component.\{-}>" end="<\/component>"
      \ contains=@JS,vueMainTag
      \ keepend

syntax region vueScript start="<directive.\{-}>" end="<\/directive>"
      \ contains=@JS,vueMainTag
      \ keepend

syntax region vueScript start="<docs.\{-}>" end="<\/docs>"
      \ contains=@MARKDOWN,vueMainTag
      \ keepend

syntax region vueScript start="<endpoint.\{-}>" end="<\/endpoint>"
      \ contains=@JS,vueMainTag
      \ keepend

syntax region vueScript start="<filter.\{-}>" end="<\/filter>"
      \ contains=@JS,vueMainTag
      \ keepend

syntax region vueScript start="<macgyver.\{-}>" end="<\/macgyver>"
      \ contains=@JS,vueMainTag
      \ keepend

syntax region vueScript start="<schema.\{-}>" end="<\/schema>"
      \ contains=@JS,vueMainTag
      \ keepend

syntax region vueScript start="<script.\{-}>" end="<\/script>"
      \ contains=@JS,vueMainTag
      \ keepend

syntax region vueScript start="<server.\{-}>" end="<\/server>"
      \ contains=@JS,vueMainTag
      \ keepend

syntax region vueScript start="<service.\{-}>" end="<\/service>"
      \ contains=@JS,vueMainTag
      \ keepend

syntax region vueStyle start="<style.\{-}>" end="<\/style>"
      \ contains=@CSS,vueMainTag
      \ keepend

syntax region vueTemplate start="<template.\{-}>" end="<\/template>"
      \ contains=@HTML,vueMainTag,vueInterpolation
      \ keepend

" ===============================================
" INTERPOLATION
" ===============================================

syntax region vueInterpolation matchgroup=vueEnclosure start="{{" end="}}"
      \ contained
      \ contains=@JS
      \ keepend

let b:current_syntax = "vue"
