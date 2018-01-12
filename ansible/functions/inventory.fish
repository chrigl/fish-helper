# Defined in /var/folders/_k/59hzmyts43x7gr826r8t63qh0000gn/T//fish.QueR2K/inventory.fish @ line 2
function inventory --description 'change to inventory and open hosts file'

	if test -z $INVENTORY_ANSIBLE_DIR
		echo "inventory: please set environment variable INVENTORY_ANSIBLE_DIR"
		return 1
	end
	set -l argc (count $argv)
	if test $argc -eq 0
		echo "inventory: usage"
		echo " ls     list all inventories"
		echo " cd     change dir to inventories, or a specific inventory"
		echo " vi     edit inventory"
		return 1
	end

	set -l inventories_dir $INVENTORY_ANSIBLE_DIR
	switch $argv[1]
		case ls
			set cmd $argv; set -e cmd[1]
			ls $cmd "$inventories_dir"
		case cd
			set -l change_dir $inventories_dir
			if test $argc -gt 1
				if test -d "$inventories_dir/$argv[2]"
					set change_dir "$change_dir/$argv[2]"
				end
			end
			cd "$change_dir"
		case vi
			if test $argc -eq 1
				echo "inventory: please pass at least one inventory name"
				return 1
			end
			set -l to_open
			for i in $argv
				if test -f $inventories_dir/$i/hosts
					set to_open $to_open "$inventories_dir/$i/hosts"
				end
			end
			if test (count $to_open) -eq 0
				echo "inventory: No such file to open"
				return 1
			end	
			vi -O $to_open
	end
end
