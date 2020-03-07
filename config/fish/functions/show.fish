# Defined in - @ line 1
function show --description 'alias show ls -l (which $argv)'
	ls -l (which $argv) $argv;
end
