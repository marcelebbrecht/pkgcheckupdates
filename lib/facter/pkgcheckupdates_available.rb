Facter.add("pkg_updates_available") do
	setcode do
		if File.exist? '/tmp/pkgcheckupdates'
			Facter::Core::Execution.exec('cat /tmp/pkgcheckupdates')
        	end
	end
end
