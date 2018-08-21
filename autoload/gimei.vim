scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! gimei#vital()
	return vital#gimei#new()
endfunction

let s:R = gimei#vital().import("Random")

function! s:dump(name)
	return {
\		"kanji" : a:name[0],
\		"hiragana" : a:name[1],
\		"katakana" : a:name[2],
\	}
endfunction


function! s:dump_fullname(first_name, last_name)
	let first = s:dump(a:first_name)
	let last  = s:dump(a:last_name)
	return {
\		"kanji" : first.kanji . " " . last.kanji,
\		"hiragana" : first.hiragana . " " . last.hiragana,
\		"katakana" : first.katakana . " " . last.katakana,
\		"first" : first,
\		"last" : last,
\	}
endfunction




function! gimei#name()
	let first_name = s:R.sample(gimei#names#first_name_all())
	let last_name = s:R.sample(g:gimei#names#list.last_name)
	return s:dump_fullname(first_name, last_name)
endfunction



function! s:dump_address(prefecture, city, town)
	let prefecture = s:dump(a:prefecture)
	let city = s:dump(a:city)
	let town = s:dump(a:town)
	return {
\		"kanji" : prefecture.kanji . city.kanji . town.kanji,
\		"hiragana" : prefecture.hiragana . city.hiragana . town.hiragana,
\		"katakana" : prefecture.katakana . city.katakana . town.katakana,
\		"prefecture" : prefecture,
\		"city" : city,
\		"town" : town,
\	}
endfunction


function! gimei#address()
	let prefecture = s:R.sample(g:gimei#addresses#list.addresses.prefecture)
	let city = s:R.sample(g:gimei#addresses#list.addresses.city)
	let town = s:R.sample(g:gimei#addresses#list.addresses.town)
	return s:dump_address(prefecture, city, town)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
