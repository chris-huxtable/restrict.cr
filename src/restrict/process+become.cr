# Copyright (c) 2018 Christian Huxtable <chris@huxtable.ca>.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

require "./lib_c/grp"
require "./lib_c/pwd"
require "./lib_c/unistd"

class Process

	# Sets the real, effective, and saved user and group for the current process to the ones specified.
	#
	# ```
	# Process.become("user", "group")
	# ```
	def self.become(user : String, group : String) : Nil
		user.check_no_null_byte
		group.check_no_null_byte

		user = LibC.getpwnam(user)
		group = LibC.getgrnam(group)

		raise "User or Group not found." if ( user.null? || group.null? )

		user = user.value.pw_uid
		group = group.value.gr_gid

		raise Errno.new("The calling process was not privileged.") if ( LibC.setgid(group) != 0 )
		raise Errno.new("The calling process was not privileged.") if ( LibC.setuid(user) != 0 )
	end

	# Returns if the process is running as root.
	def self.root?() : Bool
		return ( LibC.getuid == 0 )
	end

end