function __pubs_papers_completion
    pubs list | awk '{ gsub("[\\\\[\\\\]]", "", $1); printf $1"\t"; print gensub(/.*?"(.+?)".*/, "\\\\1", "g", $0) }'
end

function __pubs_arg_number -a number
    set -l cmd (commandline -opc)
    test (count $cmd) -eq $number
end

function __pubs_using_subcommand -a subcommand
    set -l cmd (commandline -opc)
    test (count $cmd) -gt 2; and test $subcommand = $cmd[3]
end

complete -f -c pubs -n '__fish_prog_needs_command' -l help -d 'show help message and exit'
complete -f -c pubs -n '__fish_prog_needs_command' -l version -d 'show program\'s version number and exit'

complete -f -c pubs -n '__fish_prog_needs_command' -a init -d 'initialize the pubs directory'
complete -c pubs -n '__fish_prog_using_command init' -l pubsdir -r -d 'directory where to put the pubs repository (if none, ~/.pubs is used)'
complete -c pubs -n '__fish_prog_using_command init' -l docs -r -d 'path to document directory (if not specified, documents willbe stored in /path/to/pubsdir/doc/)'

complete -f -c pubs -n '__fish_prog_needs_command' -a conf -d 'open the configuration in an editor'

complete -c pubs -n '__fish_prog_needs_command' -a add -d 'add a paper to the repository'
complete -c pubs -n '__fish_prog_using_command add' -l docfile -r -d 'pdf or ps file'
complete -c pubs -n '__fish_prog_using_command add' -l citekey -r -d 'citekey associated with the paper; if not provided, one will be generated automatically'
complete -f -c pubs -n '__fish_prog_using_command add' -l tags -r -d 'tags associated to the paper, separated by commas' -a '(pubs tag | tr " " "\n")'
complete -c pubs -n '__fish_prog_using_command add' -l doi -r -d 'doi number to retrieve the bibtex entry, if it is not provided'
complete -c pubs -n '__fish_prog_using_command add' -l isbn -r -d 'isbn number to retrieve the bibtex entry, if it is not provided'
complete -c pubs -n '__fish_prog_using_command add' -l link -d 'don\'t copy document files, just create a link.'
complete -c pubs -n '__fish_prog_using_command add' -l move -d ' move document instead of of copying (ignored if --link).'


complete -f -c pubs -n '__fish_prog_needs_command' -a rename -d 'rename the citekey of a repository'
complete -f -c pubs -n '__fish_prog_using_command rename; and __pubs_arg_number 2' -a '(__pubs_papers_completion)'

complete -f -c pubs -n '__fish_prog_needs_command' -a remove -d 'removes a publication'
complete -f -c pubs -n '__fish_prog_using_command remove' -a '(__pubs_papers_completion)'

complete -f -c pubs -n '__fish_prog_needs_command' -a list -d 'list papers'

complete -f -c pubs -n '__fish_prog_needs_command' -a doc -d 'manage the document relating to a publication'
complete -f -c pubs -n '__fish_prog_using_command doc; and __pubs_arg_number 2' -a 'add' -d 'add a document to a publication'
complete -f -c pubs -n '__fish_prog_using_command doc; and __pubs_arg_number 2' -a 'remove' -d 'remove assigned documents from publications'
complete -f -c pubs -n '__fish_prog_using_command doc; and __pubs_arg_number 2' -a 'export' -d 'export assigned documents to given path'
complete -f -c pubs -n '__fish_prog_using_command doc; and __pubs_arg_number 2' -a 'open' -d 'open an assigned document'

complete -f -c pubs -n '__fish_prog_using_command doc; and __pubs_using_subcommand open' -a '(__pubs_papers_completion)'
complete -f -c pubs -n '__fish_prog_using_command doc; and __pubs_using_subcommand remove' -a '(__pubs_papers_completion)'
complete -c pubs -n '__fish_prog_using_command doc; and __pubs_using_subcommand export' -a '(__pubs_papers_completion)'
complete -f -c pubs -n '__fish_prog_using_command doc; and __pubs_using_subcommand add; and __pubs_arg_number 4' -a '(__pubs_papers_completion)'
complete -f -c pubs -n '__fish_prog_using_command doc; and __pubs_using_subcommand add' -l force -d 'force overwriting an already assigned document'
complete -f -c pubs -n '__fish_prog_using_command doc; and __pubs_using_subcommand add' -l link -d 'do not copy document files, just create a link'
complete -f -c pubs -n '__fish_prog_using_command doc; and __pubs_using_subcommand add' -l move -d 'move document instead of of copying (ignored if --link)'

complete -f -c pubs -n '__fish_prog_needs_command' -a tag -d 'add, remove and show tags'
complete -f -c pubs -n '__fish_prog_using_command tag; and __pubs_arg_number 2' -a '(__pubs_papers_completion)'
complete -f -c pubs -n '__fish_prog_using_command tag; and __pubs_arg_number 3' -a '(pubs tag | tr " " "\n")'


complete -f -c pubs -n '__fish_prog_needs_command' -a note -d 'edit the note attached to a paper'
complete -f -c pubs -n '__fish_prog_using_command note' -a '(__pubs_papers_completion)'

complete -c pubs -n '__fish_prog_needs_command' -a export -d 'export bibliography'

complete -f -c pubs -n '__fish_prog_needs_command' -a import -d 'import paper(s) to the repository'

complete -f -c pubs -n '__fish_prog_needs_command' -a websearch -d 'launch a search on Google Scholar'

complete -f -c pubs -n '__fish_prog_needs_command' -a edit -d 'open the paper bibliographic file in an editor'
complete -f -c pubs -n '__fish_prog_using_command edit' -a '(__pubs_papers_completion)'
