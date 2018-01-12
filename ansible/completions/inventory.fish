function __inventory_needs_command
	set cmd (commandline -opc)
	test (count $cmd) -eq 1
end

function __inventory_using_command
	set cmd (commandline -opc)
	test (count $cmd) -gt 1
	and contains -- $cmd[2] $argv
end

function __inventory_entries
	inventory ls
end

complete -f -c inventory -a ls -d 'list inventories' -n '__inventory_needs_command'
complete -f -c inventory -a cd -d 'change dir inventory' -n '__inventory_needs_command'
complete -f -c inventory -a vi -d 'edit inventories' -n '__inventory_needs_command'

complete -f -c inventory -n '__inventory_using_command cd vi' -a '(__inventory_entries)' -r
