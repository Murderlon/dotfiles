" In CSS, hyphens are part of identifiers (keywords, properties, selectors...).
" By adding it to the iskeyword list, vim will consider identifiers as a whole word.
au! FileType css,scss setl iskeyword+=-
