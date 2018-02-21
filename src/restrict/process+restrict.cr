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

require "./lib_c/unistd"

require "./process+chroot"
require "./process+become"

class Process

	# Changes the root directory and the current working directory for the current
	# process and sets the real, effective, and saved user and group for the current
	# process to the ones specified.
	#
	# ```
	# Process.restrict("/var/empty", "nobody", "nobody")
	# ```
	def self.restrict(path : String, user : String, group : String) : Nil
		chroot(path)
		become(user, group)
	end

	# Forks the current process then changes the root directory and the current working
	# directory and sets the real, effective, and saved user and group to the ones
	# specified before yielding to the given block.
	#
	# ```
	# Process.restrict("/var/empty", "nobody", "nobody", should_wait: true) {
	#   # New restricted process
	# }
	# ```
	def self.restrict(path : String, user : String, group : String, should_wait : Bool = true, &block) : self
		proc = Process.fork() {
			restrict(path, user, group)
			yield()
		}

		proc.wait if should_wait
		return proc
	end
end